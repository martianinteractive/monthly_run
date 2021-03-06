class Lease < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  
  attr_accessor :length_in_months

  belongs_to :unit
  belongs_to :admin_user
  has_many :terms
  has_many :tenants, through: :terms
  has_many :payments do
    def paid_the_same_day?(date)
      for_month(date).collect(&:collected_on).uniq.length == 1
    end

    def date_collected(date)
      for_month(date).first.collected_on
    end
  end
  has_many :charges
  has_many :periodic_charges, -> { where(frequency: 'monthly') }, class_name: "Charge" do

    def unpaid(date=Time.zone.now.to_date)
      where(Payment.by_month(Lease.parse_date(date)).where("payments.charge_id = charges.id").exists.not)
    end

    def paid(date=Time.zone.now.to_date)
      where(Payment.by_month(Lease.parse_date(date)).where("payments.charge_id = charges.id").exists)
    end

  end
  has_many :one_time_charges, -> { where(frequency: 'one_time') }, class_name: "Charge" do
    
    def unpaid
      includes(:payments).where(payments: {lease_id: nil})
    end

    def paid
      joins(:payments)
    end
  end

  accepts_nested_attributes_for :tenants, allow_destroy: true
  accepts_nested_attributes_for :charges, allow_destroy: true

  delegate :formatted_address, to: :unit

  validates :charges, :starts_on, :ends_on, :unit, presence: true
  validates_date :starts_on, allow_blank: true
  validates_numericality_of :length_in_months, only_integer: true, allow_blank: true
  validates_inclusion_of :length_in_months, in: (1..60), allow_blank: true

  scope :active, -> { where("CURRENT_DATE < ends_on") }
  scope :inactive, -> { where("CURRENT_DATE >= ends_on") }

  scope :month, -> {
    left_joins(:unit, :charges)
  }

  scope :paid, -> {
    joins(:payments).on(Lease.arel_table[:id].eq(Payment.arel_table[:lease_id]).and(Payment.arel_table[:applicable_period].between(Date.yesterday..Date.today)))
  }

  scope :total, -> {
   left_joins(:payments).on(Lease.arel_table[:id].eq(Payment.arel_table[:lease_id]).and(Payment.arel_table[:applicable_period].between(Date.yesterday..Date.today)))
  }

  scope :monthly, -> { where(frequency: 'monthly') }
  
  before_save :update_ends_on

  def name
    unit.name
  end

  def receive_full_payment!(options={})
    RentReceiver.process_full_payment!(self, options)
  end

  def length_in_words
    distance_of_time_in_words(starts_on, ends_on)
  end

  def update_ends_on
    return unless length_in_months.present?
    parsed_starts_on = starts_on.is_a?(String) ? Chronic.parse(starts_on) : starts_on
    self.ends_on = parsed_starts_on + length_in_months.send(:months)
  end

  def time_left
    ends_on - Time.zone.today
  end

  def periodic_unpaid_amount(date)
    periodic_charges.unpaid(date).total_amount
  end

  def periodic_paid_amount(date)
    periodic_charges.paid(date).total_amount
  end

  def one_time_unpaid_amount
    one_time_charges.unpaid.total_amount 
  end

  def one_time_paid_amount
    one_time_charges.paid.total_amount
  end

  def amount_due(date=Time.zone.now.to_date)
    total_period_amount_due(date)
  end

  alias_method :monthly_rent, :amount_due

  def amount_paid(date)
    total_period_amount_paid(date)
  end

  def total_period_amount_due(date)
    periodic_unpaid_amount(date) + one_time_unpaid_amount
  end

  def total_period_amount_paid(date)
    periodic_paid_amount(date) + one_time_paid_amount
  end

  def self.parse_date(date)
    if date.is_a?(String)
      Chronic.parse(date.humanize)
    elsif date.is_a?(Date)
      date
    elsif date.is_a?(ActiveSupport::TimeWithZone)
      date.to_date
    else
      raise ArgumentError, "invalid date"
    end
  end

end

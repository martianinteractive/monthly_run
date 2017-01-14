class Lease < ActiveRecord::Base

  belongs_to :unit
  belongs_to :admin_user
  has_many :terms
  has_many :tenants, through: :terms
  has_many :rents
  has_many :payments
  has_many :charges
  has_many :periodic_charges, -> { where(frequency: 'monthly') }, class_name: "Charge" do

    def unpaid(date=Time.zone.now.to_date)
      where(Payment.by_month(Lease.parse_date(date)).where(payments: {charge_id: Charge.arel_table[:id]}).exists.not)
    end

  end
  has_many :one_time_charges, -> { where(frequency: 'one_time') }, class_name: "Charge" do
    
    def unpaid
      includes(:payments).where(payments: {lease_id: nil})
    end
  end

  accepts_nested_attributes_for :tenants
  accepts_nested_attributes_for :charges

  delegate :formatted_address, to: :unit

  validates :charges, :starts_on, :length_in_months, :unit, presence: true
  validates_date :starts_on, allow_blank: true
  validates_numericality_of :length_in_months, only_integer: true, allow_blank: true
  validates_inclusion_of :length_in_months, in: (1..60), allow_blank: true

  scope :active, -> { where("CURRENT_DATE < ends_on") }
  scope :inactive, -> { where("CURRENT_DATE >= ends_on") }

  scope :monthly_balance, -> (date=Time.zone.now.to_date) {
    select("leases.*, COUNT(charges.id) AS charges_count, COUNT(payments.id) as payments_count").
    joins("LEFT JOIN charges ON charges.lease_id = leases.id").
    joins("LEFT JOIN payments ON payments.charge_id = charges.id AND payments.applicable_period BETWEEN '#{date.beginning_of_month.to_s(:db)}' AND '#{date.end_of_month.to_s(:db)}'").
    group("leases.id")
  }

  before_save :update_ends_on

  def name
    unit.name
  end

  def receive_full_payment!(options={})
    RentReceiver.process_full_payment!(self, options)
  end

  def update_ends_on
    parsed_starts_on = starts_on.is_a?(String) ? Chronic.parse(starts_on) : starts_on
    self.ends_on = parsed_starts_on + length_in_months.send(:months)
  end

  def time_left
    ends_on - Time.zone.today
  end

  def periodic_unpaid_amount(date)
    periodic_charges.unpaid(date).total_amount
  end

  def one_time_unpaid_amount
    one_time_charges.unpaid.total_amount 
  end

  def amount_due(date=Time.zone.now.to_date)
    total_period_amount(date)
  end

  def total_period_amount(date)
    periodic_unpaid_amount(date) + one_time_unpaid_amount
  end

end

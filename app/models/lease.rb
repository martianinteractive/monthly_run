class Lease < ActiveRecord::Base
  attr_accessor :starts_on

  belongs_to :unit
  belongs_to :admin_user
  has_many :terms
  has_many :tenants, through: :terms
  has_many :rents
  has_many :payments
  has_many :charges
  has_many :periodic_charges, -> { where(frequency: 'monthly') }, class_name: "Charge" do
    def unpaid(date=Time.zone.now.to_date)
      joins("LEFT JOIN payments ON payments.charge_id = charges.id").where(Payment.arel_table[:applicable_period].gt(date.beginning_of_month))
    end
  end
  has_many :one_time_charges, -> { where(frequency: 'one_time') }, class_name: "Charge"

  accepts_nested_attributes_for :tenants
  accepts_nested_attributes_for :charges

  delegate :formatted_address, to: :unit

  validates :charges, :starts_on, :length_in_months, :unit, presence: true
  validates_date :starts_on, allow_blank: true
  validates_numericality_of :length_in_months, only_integer: true, allow_blank: true
  validates_inclusion_of :length_in_months, in: (1..60), allow_blank: true

  scope :active, -> { where("CURRENT_DATE < ends_on") }
  scope :inactive, -> { where("CURRENT_DATE >= ends_on") }

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
    ends_on - Date.today
  end

  def amount_due
    periodic_charge_amount
  end

  def periodic_charge_amount
    Money.new(periodic_charges.to_a.sum(&:amount))
  end

  def one_time_charge_amount
    Money.new(one_time_charges.to_a.sum(&:amount))
  end

end

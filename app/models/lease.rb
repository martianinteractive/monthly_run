class Lease < ActiveRecord::Base
  belongs_to :unit
  belongs_to :admin_user
  has_many :terms
  has_many :tenants, through: :terms
  has_many :rents
  has_many :charges
  has_many :periodic_charges, -> { where(frequency: ['weekly', 'monthly', 'yearly']) }, class_name: "Charge"
  has_many :payments

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

  def update_period
    parsed_starts_on = Chronic.parse(starts_on)
    self.period = (parsed_starts_on..(parsed_starts_on + length_in_months.send(:months)))
  end

  def update_ends_on
    self.ends_on = starts_on + length_in_months.send(:months)
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

end

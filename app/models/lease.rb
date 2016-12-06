class Lease < ActiveRecord::Base
  belongs_to :unit
  has_many :terms
  has_many :tenants, through: :terms

  accepts_nested_attributes_for :tenants

  validates :starts_on, :length_in_months, :unit, presence: true

  scope :active, -> { where("CURRENT_DATE < ends_on") }
  scope :inactive, -> { where("CURRENT_DATE >= ends_on") }

  monetize :security_deposit_in_cents, allow_nil: false
  monetize :monthly_rent_in_cents, allow_nil: false
  monetize :pet_fee_in_cents, allow_nil: false

  before_save :update_ends_on

  def update_ends_on
    self.ends_on = starts_on + length_in_months.send(:months)
  end

  def time_left
    ends_on - Date.today
  end

end

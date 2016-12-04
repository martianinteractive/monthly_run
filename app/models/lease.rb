class Lease < ActiveRecord::Base
  belongs_to :unit
  has_many :tenants

  accepts_nested_attributes_for :tenants

  monetize :security_deposit_in_cents, allow_nil: false
  monetize :monthly_amount_in_cents, allow_nil: false

  before_save :update_ends_on

  def update_ends_on
    self.ends_on = starts_on + length_in_months.send(:months)
  end

  def time_left
    ends_on - Date.today
  end

end

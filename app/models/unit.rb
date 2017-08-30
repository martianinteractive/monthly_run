class Unit < ActiveRecord::Base
  attr_accessor :address
  
  belongs_to :property
  belongs_to :unit_type
  has_many :leases
  has_one :active_lease, -> { active }, class_name: "Lease"
  has_many :past_leases, -> { inactive }, class_name: "Lease"
  has_many :payments, through: :active_lease
  has_many :past_payments, through: :past_leases, source: :payments

  def county
    administrative_area_level_2
  end

  def current_tenants
    if active_lease && active_lease.tenants.any?
      active_lease.tenants
    else
      []
    end
  end

  def has_active_lease?
    active_lease.present?
  end

end

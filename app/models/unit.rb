class Unit < ActiveRecord::Base
  belongs_to :property
  belongs_to :unit_type
  has_many :leases
  has_one :active_lease, -> { where("CURRENT_DATE < ends_on") }, class_name: "Lease"

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

  def full_address
    if number.present?
      "#{address} #{number}, #{city}, #{state} #{zip}"
    else
      "#{address}, #{city}, #{state} #{zip}"
    end
  end

end

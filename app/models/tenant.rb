class Tenant < ActiveRecord::Base
  include FullNameSplitter
  
  belongs_to :property
  belongs_to :lease

  scope :inactive, -> { join(:lease).where("CURRENT_DATE > leases.ends_on") }
  scope :active, -> { join(:lease).where("CURRENT_DATE <= leases.ends_on") }

  def rented_address
    lease.unit.full_address
  end
end

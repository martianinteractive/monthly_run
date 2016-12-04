class Unit < ActiveRecord::Base
  belongs_to :property
  belongs_to :unit_type
  has_many :leases
  has_one :active_lease, -> { where("CURRENT_DATE < ends_on") }, class_name: "Lease"

end

class Unit < ActiveRecord::Base
  belongs_to :property
  belongs_to :unit_type
  has_many :leases
end

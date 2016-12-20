class Tenant < ActiveRecord::Base
  include FullNameSplitter
  
  belongs_to :property
  has_many :terms
  has_many :leases, through: :terms
  has_one :active_term, class_name: "Term"
  has_one :active_lease, -> { where("CURRENT_DATE < leases.ends_on") }, through: :active_term
  has_one :active_unit, through: :active_lease, source: :unit
  has_many :units, through: :leases, source: :unit

  scope :inactive, -> { joins(:leases).where("CURRENT_DATE > leases.ends_on") }
  scope :active, -> { joins(:leases).where("CURRENT_DATE <= leases.ends_on") }

  def rented_address
    active_unit&.formatted_address || last_lease&.unit&.formatted_address
  end

  def last_lease
    leases&.last
  end
end

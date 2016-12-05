class Property < ActiveRecord::Base
  
  belongs_to :account
  has_many :units
  belongs_to :unit_type

  before_create :create_unit, if: :property_same_as_unit?

  def name
    name = read_attribute(:name)
    name.blank? ? address : name
  end

  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end

  private

  def property_same_as_unit?
    is_rental_unit?
  end

  def create_unit
    units.build({
      address:  address,
      city:     city,
      state:    state,
      zip:      zip,
      country:  country,
      rent_due: rent_due,
      unit_type: unit_type
      })
  end
end

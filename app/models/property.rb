class Property < ActiveRecord::Base
  
  belongs_to :account
  has_many :units
  belongs_to :unit_type

  before_create :create_unit, if: :property_same_as_unit?

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
      rent_due: rent_due
      })
  end
end

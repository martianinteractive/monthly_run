class Property < ActiveRecord::Base
  attr_accessor :address
  
  belongs_to :account
  belongs_to :unit_type
  has_many :units

  validates :account, :address, :unit_type, presence: true

  before_create :create_unit, if: :property_same_as_unit?

  def county
    administrative_area_level_2
  end

  def created_by
    id = read_attribute(:created_by)
    return "" if id.blank?
    user = AdminUser.find(id)
    user ? user.full_name : ""
  end

  private

  def property_same_as_unit?
    is_rental_unit?
  end

  def create_unit
    units.build({
      unit_type: unit_type,
      latitude: latitude,
      longitude: longitude,
      location: location,
      location_type: location_type,
      formatted_address: formatted_address,
      bounds: bounds,
      viewport: viewport,
      route: route,
      street_number: street_number,
      postal_code: postal_code,
      locality: locality,
      sublocality: sublocality,
      country: country,
      country_short: country_short,
      administrative_area_level_1: administrative_area_level_1,
      administrative_area_level_2: administrative_area_level_2,
      place_id: place_id,
      reference: reference,
      url: url,
      name: name
      })
  end
end

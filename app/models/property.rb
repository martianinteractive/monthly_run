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

  private

  def property_same_as_unit?
    is_rental_unit?
  end

  def create_unit
    units.build({
      rent_due: rent_due,
      unit_type: unit_type
      })
  end
end

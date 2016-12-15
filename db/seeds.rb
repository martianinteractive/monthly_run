# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
DatabaseCleaner.clean_with(:truncation)
AdminUser.create!(first_name: "Sergio", last_name: "Bayona", email: 'admin@example.com', password: 'password', password_confirmation: 'password')
account = Account.create(name: "Urban Home Development, LLC")
UnitType.create!([{name: "Apartment"}, {name: "Studio"}, {name: "Single-Family Home"}, {name: "Duplex"}, {name: "Townhouse"}, {name: "Condominium"}])
unit_type = UnitType.where(name: "Single-Family Home").first

Property.create!({
  account: account,
  created_by: "1",
  updated_by: "1",
  is_rental_unit: true,
  unit_type: unit_type,
  rent_due: 1,
  latitude: "33.55483950000001",
  longitude: "-84.36649949999997",
  location: "33.55484,-84.366499",
  location_type: "PLACES",
  address: "Howard Pl, Jonesboro, GA 30236, USA",
  formatted_address: "Howard Pl, Jonesboro, GA 30236, USA",
  bounds: "",
  viewport: "",
  route: "Howard Place",
  street_number: "",
  postal_code: "30236",
  locality: "Jonesboro",
  sublocality: "",
  country: nil,
  country_short: "US",
  administrative_area_level_1: "Georgia",
  administrative_area_level_2: "Clayton County",
  place_id: "ChIJoWbA6cL79IgRcIOrx0eUoxs",
  reference:
   "CmRbAAAANirizXA06S7aqY1RPAouHeD2aUE_aVlM8NGfAPjuvPrACtY7W4f28RMAQK_Jz9A9e9ixtzOdBz4Rgt5ljOVo1n2nJ8GuXOCv6H9ub91YZktFhHWO-DMSrhg-14fDX46YEhCIFUiLfGCfLMw2BD3jqbixGhRNfnF9jFhk32f1Ss0eBHaWTrRz2A",
  url: "https://maps.google.com/?q=Howard+Pl,+Jonesboro,+GA+30236,+USA&ftid=0x88f4fbc2e9c066a1:0x1ba39447c7ab8370",
  name: "Howard Place"
  })

unit = Unit.first

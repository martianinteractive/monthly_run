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
  unit_type_id: unit_type.id,
  address: "211 Southern Hill Dr, Duluth, GA 30097",
  formatted_address: "211 Southern Hill Dr, Duluth, GA 30097",
  account: account,
  is_rental_unit: true
  })

unit = Unit.first



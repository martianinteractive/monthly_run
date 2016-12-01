# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
DatabaseCleaner.clean_with(:truncation)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
account = Account.create(name: "Urban Home Development, LLC")
Property.create!({
  address: "7317 Howard  Place", 
  city: "Jonesboro", 
  state: "GA", 
  zip: "30236", 
  country: "United States", 
  unit_name: "Single-Family Home",
  rent_due: "1st day of next month",
  account: account,
  is_rental_unit: true
  })
UnitType.create!([{name: "Apartment"}, {name: "Studio"}, {name: "Single-Family Home"}, {name: "Duplex"}, {name: "Townhouse"}, {name: "Condominium"}])

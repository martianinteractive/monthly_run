FactoryGirl.define do
  factory :property do
    address "7317 Howard Place"
    city "Jonesboro"
    state "GA"
    zip "30236"
    country "United States"
    account
    unit_type
  end
end

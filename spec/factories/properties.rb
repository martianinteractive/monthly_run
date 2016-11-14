FactoryGirl.define do
  factory :property do
    name "MyString"
    address "MyText"
    city "MyString"
    state "MyString"
    zip "MyString"
    country "MyString"
    unit_name "MyString"
    tax_number ""
    rent_due "MyString"
    units_count 1
    account nil
  end
end

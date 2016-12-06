FactoryGirl.define do
  factory :unit do
    number "MyString"
    address "MyText"
    city "MyString"
    state "MyString"
    zip "MyString"
    country "MyString"
    dimension "MyString"
    notes "MyText"
    issues_count 1
    property nil
    unit_type nil
  end
end

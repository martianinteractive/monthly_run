FactoryGirl.define do
  factory :unit do
    formatted_address "211 Southern Hill Dr, Duluth, GA 30097"
    country "US"
    notes "MyText"
    issues_count 1
    property
    unit_type
  end
end

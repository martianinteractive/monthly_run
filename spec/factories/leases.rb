FactoryGirl.define do
  factory :lease do
    terms "MyText"
    starts_on "2016-11-13"
    length_in_months 1
    signed_by "MyString"
    monthly_rent_in_cents 1
  end
end

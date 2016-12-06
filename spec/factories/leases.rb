FactoryGirl.define do
  factory :lease do
    starts_on "2016-11-13"
    length_in_months 1
    monthly_rent_in_cents 1
    unit
  end
end

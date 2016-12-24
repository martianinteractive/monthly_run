FactoryGirl.define do
  factory :lease do
    starts_on Date.yesterday
    length_in_months 12
    unit
  end
end

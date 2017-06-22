FactoryGirl.define do
  factory :lease do
    starts_on Date.yesterday
    length_in_months 12
    unit
    charges { [build(:charge)] }
    admin_user
  end
end

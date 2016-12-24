FactoryGirl.define do
  factory :lease do
    starts_on Date.yesterday
    length_in_months 12
    preferred_payment_method "direct_deposit"
  end
end

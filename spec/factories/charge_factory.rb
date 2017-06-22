FactoryGirl.define do
  factory :charge do
    name "Rent"
    frequency "monthly"
    amount_in_cents "1200.00"
  end
end

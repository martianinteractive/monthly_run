FactoryGirl.define do
  factory :payment do
    lease nil
    name "MyString"
    amount_due 1
    amount_collected 1
    collected_on "2016-12-23"
    deposited_on "2016-12-23"
    received_via "MyString"
    admin_user nil
    applicable_period "2016-12-23"
    charge nil
  end
end

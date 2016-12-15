FactoryGirl.define do
  factory :rent do
    rent_due 1
    rent_collected 1
    month "MyString"
    collected_at "2016-12-14 21:57:03"
    deposited_at "2016-12-14 21:57:03"
    received_via "MyString"
    notes "MyText"
  end
end

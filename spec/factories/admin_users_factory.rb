FactoryGirl.define do
  factory :admin_user do
    first_name "James"
    last_name  "Doe"
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "abcd1234"
    password_confirmation "abcd1234"
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name Faker::Name.name
    email
    password '1234qwer'
    password_confirmation '1234qwer'
  end
end

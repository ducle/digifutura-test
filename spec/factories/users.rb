FactoryGirl.define do
  factory :user do
    name
    email
    password '1234qwer'
    password_confirmation '1234qwer'
  end
end

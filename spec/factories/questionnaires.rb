FactoryGirl.define do
  factory :questionnaire do
    name Faker::Name.name
    association :owner, factory: :user
  end
end

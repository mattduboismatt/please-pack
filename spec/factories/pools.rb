FactoryGirl.define do
  factory :pool do
    title { Faker::Commerce.department }
  end
end

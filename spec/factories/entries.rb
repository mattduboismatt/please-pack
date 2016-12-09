FactoryGirl.define do
  factory :entry do
    pool
    name { Faker::StarWars.character }
  end
end

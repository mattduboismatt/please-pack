FactoryGirl.define do
  factory :entry do
    pool
    points { (0..100).to_a.sample }
    name { Faker::StarWars.character }
  end
end

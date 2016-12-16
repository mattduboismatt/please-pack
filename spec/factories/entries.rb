FactoryGirl.define do
  factory :entry do
    pool
    sequence(:name) { |n| Faker::StarWars.character + n.to_s }

    trait :with_points do
      after(:create) do |entry|
        picks = create_list(:pick, 2, entry: entry)
        picks.each { |pick| create(:contestant_score, contestant: pick.contestant) }
      end
    end
  end
end

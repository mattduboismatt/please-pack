FactoryGirl.define do
  factory :pool do
    title { Faker::Commerce.department }

    trait :with_picks do
      after(:create) do |pool|
        entry = create(:entry, pool: pool)
        contestants = create_list(:contestant, 4, pool: pool)
        contestants.sample(2).each { |contestant| create(:pick, entry: entry, contestant: contestant) }
      end
    end
  end
end

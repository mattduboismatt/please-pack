FactoryGirl.define do
  factory :contestant do
    pool
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    residence { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    description { Faker::Hipster.sentence }
    eliminated { false }

    trait :eliminated do
      eliminated { true }
    end
  end
end

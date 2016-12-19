FactoryGirl.define do
  factory :score do
    points { (1..10).to_a.sample }
    mechanism { Score::MECHANISMS.all.sample }

    trait :advancement do
      points { 1 }
      mechanism { Score::MECHANISMS::ADVANCEMENT }
    end

    trait :quickfire do
      points { 1 }
      mechanism { Score::MECHANISMS::QUICKFIRE }
    end

    trait :weekly_winner do
      points { 2 }
      mechanism { Score::MECHANISMS::WEEKLY_WINNER }
    end
  end
end

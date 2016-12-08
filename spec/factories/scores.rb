FactoryGirl.define do
  factory :score do
    points { (1..10).to_a.sample }
    mechanism { Score::MECHANISMS.all.sample }
  end
end

FactoryGirl.define do
  factory :pick do
    transient do
      pool { build(:pool) }
    end

    entry { build(:entry, pool: pool) }
    contestant { build(:contestant, pool: pool) }
  end
end

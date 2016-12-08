require "rails_helper"

RSpec.describe Score do
  subject { build(:score) }

  it "has a valid factory" do
    expect(subject.valid?).to eq true
    subject.save!
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :points }
    it { is_expected.to validate_presence_of :mechanism }
    it { is_expected.to validate_inclusion_of(:mechanism).in_array(Score::MECHANISMS.all) }
    it { is_expected.to validate_numericality_of(:points).is_greater_than(0) }
  end

  describe "associations" do
    it { is_expected.to have_many :contestant_scores }
  end
end

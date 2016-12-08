require "rails_helper"

RSpec.describe ContestantScore do
  subject { build(:contestant_score) }

  it "has a valid factory" do
    expect(subject.valid?).to eq true
    subject.save!
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :contestant }
    it { is_expected.to validate_presence_of :score }
  end

  describe "associations" do
    it { is_expected.to belong_to :contestant }
    it { is_expected.to belong_to :score }
  end
end

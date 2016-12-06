require "rails_helper"

RSpec.describe Pick do
  subject { build(:pick) }

  it "has a valid factory" do
    expect(subject.valid?).to eq true
    subject.save!
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :entry }
    it { is_expected.to validate_presence_of :contestant }
  end

  describe "associations" do
    it { is_expected.to belong_to :entry }
    it { is_expected.to belong_to :contestant }
  end
end

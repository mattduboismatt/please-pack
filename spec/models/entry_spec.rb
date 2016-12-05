require "rails_helper"

RSpec.describe Entry do
  subject { build(:entry) }

  it "has a valid factory" do
    expect(subject.valid?).to eq true
    subject.save!
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :pool }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :points }
  end

  describe "associations" do
    it { is_expected.to belong_to :pool }
  end
end

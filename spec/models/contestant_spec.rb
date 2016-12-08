require "rails_helper"

RSpec.describe Contestant do
  subject { build(:contestant) }

  it "has a valid factory" do
    expect(subject.valid?).to eq true
    subject.save!
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :pool }
    it { is_expected.to validate_presence_of :first_name }
  end

  describe "associations" do
    it { is_expected.to belong_to :pool }
    it { is_expected.to have_many :contestant_scores }
    it { is_expected.to have_many(:scores).through(:contestant_scores) }
  end
end

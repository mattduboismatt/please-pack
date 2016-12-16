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
    it { is_expected.to have_many(:contestant_scores).dependent(:destroy) }
    it { is_expected.to have_many(:scores).through(:contestant_scores) }
    it { is_expected.to have_many(:picks).dependent(:destroy) }
  end

  describe "#points" do
    let!(:contestant_score) { create(:contestant_score, contestant: subject) }
    let!(:other_contestant_score) { create(:contestant_score, contestant: subject) }
    let!(:unknown_contestant_score) { create(:contestant_score) }
    let(:expected_points) { [contestant_score, other_contestant_score].map(&:score).map(&:points).sum }

    it "is the sum of the points of all scores" do
      expect(subject.points).to eq expected_points
    end
  end
end

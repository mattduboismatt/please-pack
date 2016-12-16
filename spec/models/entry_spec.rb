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
  end

  describe "associations" do
    it { is_expected.to belong_to :pool }
    it { is_expected.to have_many(:picks).dependent(:destroy) }
    it { is_expected.to have_many(:contestants).through(:picks) }
  end

  describe "#points" do
    let(:contestant) { create(:contestant) }
    let!(:contestant_score1) { create(:contestant_score, contestant: contestant) }
    let!(:contestant_score2) { create(:contestant_score, contestant: contestant) }
    let(:other_contestant) { create(:contestant) }
    let!(:other_contestant_score) { create(:contestant_score, contestant: other_contestant) }
    let!(:unknown_contestant_score) { create(:contestant_score) }
    let!(:pick) { create(:pick, entry: subject, contestant: contestant) }
    let!(:other_pick) { create(:pick, entry: subject, contestant: other_contestant) }
    let(:expected_points) { [contestant_score1, contestant_score2, other_contestant_score].map(&:score).map(&:points).sum }

    it "is the sum of the points of all picked contestants" do
      expect(subject.points).to eq expected_points
    end
  end
end

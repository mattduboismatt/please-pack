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

  describe "scopes" do
    subject { described_class }

    describe ".excluding_contestants" do
      let(:pool) { create(:pool) }
      let!(:picks) { create_list(:pick, 3, pool: pool) }
      let(:contestant_ids) { picks.map { |pick| pick.contestant.id } }
      let!(:other_picks) { create_list(:pick, 2, pool: pool) }

      it "includes picks where the contestant ID was not passed in" do
        expect(subject.excluding_contestants(contestant_ids)).to match_array other_picks
      end
    end
  end
end

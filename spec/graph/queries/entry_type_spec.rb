require "rails_helper"

RSpec.describe Queries::EntryType do
  subject { Queries::EntryType }

  context "fields" do
    let(:fields) { %w(id model_id name points pool picks) }

    it "has the proper fields" do
      expect(subject.fields.keys).to match_array fields
    end

    describe "model_id" do
      subject { Queries::EntryType.fields["model_id"] }
      let(:entry) { create(:entry) }

      it "is the database id of the object" do
        expect(subject.resolve(entry, nil, nil)).to eq entry.id
      end
    end

    describe "picks" do
      subject { Queries::EntryType.fields["picks"] }
      let(:entry) { create(:entry) }
      let!(:picks) { create_list(:pick, 3, entry: entry, pool: entry.pool) }
      let!(:other_pick) { create(:pick, pool: entry.pool) }
      let(:resolved) { subject.resolve(entry, nil, nil) }

      it "is a list of picks for that pool" do
        expect(resolved).to match_array picks
        expect(resolved.first.entry).to eq entry
      end
    end
  end
end

require "rails_helper"

RSpec.describe Queries::EntryType do
  subject { Queries::EntryType }

  context "fields" do
    let(:fields) { %w(id model_id name points) }

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
  end
end

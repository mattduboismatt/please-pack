require "rails_helper"

RSpec.describe Queries::PickType do
  subject { Queries::PickType }

  context "fields" do
    let(:fields) { %w(id model_id contestant entry) }

    it "has the proper fields" do
      expect(subject.fields.keys).to match_array fields
    end

    describe "model_id" do
      subject { Queries::PickType.fields["model_id"] }
      let(:pick) { create(:pick) }

      it "is the database id of the object" do
        expect(subject.resolve(pick, nil, nil)).to eq pick.id
      end
    end
  end
end

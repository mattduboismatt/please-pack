require "rails_helper"

RSpec.describe Queries::ContestantType do
  subject { Queries::ContestantType }

  context "fields" do
    let(:fields) { %w(id model_id first_name last_name residence description points pool) }

    it "has the proper fields" do
      expect(subject.fields.keys).to match_array fields
    end

    describe "model_id" do
      subject { Queries::ContestantType.fields["model_id"] }
      let(:contestant) { create(:contestant) }

      it "is the database id of the object" do
        expect(subject.resolve(contestant, nil, nil)).to eq contestant.id
      end
    end
  end
end

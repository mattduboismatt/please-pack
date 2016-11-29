require "rails_helper"

RSpec.describe Queries::PoolType do
  subject { Queries::PoolType }

  context "fields" do
    let(:fields) { %w(id model_id title) }

    it "has the proper fields" do
      expect(subject.fields.keys).to match_array fields
    end

    describe "model_id" do
      subject { Queries::PoolType.fields["model_id"] }
      let(:pool) { create(:pool) }

      it "is the database id of the object" do
        expect(subject.resolve(pool, nil, nil)).to eq pool.id
      end
    end
  end
end

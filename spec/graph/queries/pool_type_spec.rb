require "rails_helper"

RSpec.describe Queries::PoolType do
  subject { Queries::PoolType }

  context "fields" do
    let(:fields) { %w(id model_id title contestants GraphQL::Relay::Define::AssignConnection) }

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

    describe "contestants" do
      subject { Queries::PoolType.fields["contestants"] }
      let(:pool) { create(:pool) }
      let!(:contestants) { create_list(:contestant, 3, pool: pool) }
      let!(:other_contestant) { create(:contestant) }
      let(:resolved) { subject.resolve(pool, nil, nil).object }

      it "is a list of contestants for that pool" do
        expect(resolved).to match_array contestants
        expect(resolved.first.pool).to eq pool
      end
    end
  end
end

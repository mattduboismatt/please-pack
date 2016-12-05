require "rails_helper"

RSpec.describe Queries::Viewer do
  subject { Queries::Viewer }

  context "fields" do
    let(:fields) { %w(id pools pool GraphQL::Relay::Define::AssignConnection) }

    it "has the proper fields" do
      expect(subject.fields.keys).to match_array fields
    end
  end

  context "pools" do
    subject { Queries::Viewer.fields["pools"] }
    let!(:pools) { create_list(:pool, 3) }

    it "is all pools" do
      expect(subject.resolve(nil, nil, nil).object).to eq pools
    end
  end

  context "pool" do
    subject { Queries::Viewer.fields["pool"] }
    let!(:pools) { create_list(:pool, 2) }
    let(:pool) { create(:pool) }
    let(:args) { { "model_id" => pool_id } }

    context "success" do
      let(:pool_id) { pool.id }
      it "is the pool" do
        expect(subject.resolve(nil, args, nil)).to eq pool
      end
    end

    context "failure" do
      let(:pool_id) { 1234 }
      it "raises an error" do
        expect do
          subject.resolve(nil, args, nil)
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end

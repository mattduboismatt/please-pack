require "rails_helper"

RSpec.describe Queries::RootType do
  subject { Queries::RootType }

  context "fields" do
    let(:fields) { %w(node lists pool) }

    it "has the proper fields" do
      expect(subject.fields.keys).to match_array fields
    end
  end

  context "pool" do
    subject { Queries::RootType.fields["pool"] }
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
      let(:pool_id) { 17 }
      it "raises an error" do
        expect do
          subject.resolve(nil, args, nil)
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end

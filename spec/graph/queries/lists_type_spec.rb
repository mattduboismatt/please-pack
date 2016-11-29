require "rails_helper"

RSpec.describe Queries::ListsType do
  subject { Queries::ListsType }

  context "fields" do
    let(:fields) { %w(pools) }

    it "has the proper fields" do
      expect(subject.fields.keys).to match_array fields
    end
  end

  context "pools" do
    subject { Queries::ListsType.fields["pools"] }
    let!(:pools) { create_list(:pool, 3) }

    it "is all pools" do
      expect(subject.resolve(nil, nil, nil)).to eq pools
    end
  end
end

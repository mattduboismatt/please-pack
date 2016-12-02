require "rails_helper"

RSpec.describe Queries::RootType do
  subject { Queries::RootType }

  context "fields" do
    let(:fields) { %w(node viewer) }

    it "has the proper fields" do
      expect(subject.fields.keys).to match_array fields
    end
  end
end

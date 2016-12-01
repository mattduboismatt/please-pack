require "rails_helper"

RSpec.describe Mutations::CreatePool do
  subject { Mutations::CreatePool.field }
  let(:graphql_args) { GraphQL::Query::Arguments.new(input: args.merge(clientMutationId: "0")) }
  let(:graphql_context) { {} }
  let(:graphql_result) { subject.resolve(nil, graphql_args, graphql_context) }

  context "with valid title" do
    let(:args) { { pool_title: "New Great Show Season 100" } }

    it "creates a new pool" do
      expect { graphql_result }.to change(Pool, :count).from(0).to(1)
      pool = Pool.last
      expect(pool.title).to eq args[:pool_title]
    end
  end

  context "with invalid title" do
    let(:args) { { pool_title: nil } }

    it "does not create a new pool" do
      expect { graphql_result }.to raise_error ActiveRecord::RecordInvalid
      expect(Pool.count).to eq 0
    end
  end
end

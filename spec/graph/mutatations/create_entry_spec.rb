require "rails_helper"

RSpec.describe Mutations::CreateEntry do
  subject { Mutations::CreateEntry.field }
  let(:graphql_args) { GraphQL::Query::Arguments.new(input: args.merge(clientMutationId: "0")) }
  let(:graphql_context) { {} }
  let(:graphql_result) { subject.resolve(nil, graphql_args, graphql_context) }
  let(:args) { { name: "Good Pick Rick" } }
  let(:pool) { create(:pool) }
  let(:pool_graph_id) { GraphQL::Relay::GlobalNodeIdentification.new.to_global_id("Pool", pool.id) }

  context "with a pool" do
    before { args[:pool_id] = pool_graph_id }

    it "creates an entry for that pool" do
      expect { graphql_result }.to change(pool.reload.entries, :count).from(0).to(1)
      entry = Entry.last
      expect(entry.pool).to eq pool
      expect(entry.name).to eq args[:name]
      expect(entry.points).to eq 0
    end

    it "raises an error if invalid inputs are supplied" do
      args[:name] = ""
      expect { graphql_result }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end

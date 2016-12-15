require "rails_helper"

RSpec.describe Mutations::DeleteEntry do
  subject { Mutations::DeleteEntry.field }
  let(:graphql_args) { GraphQL::Query::Arguments.new(input: args.merge(clientMutationId: "0")) }
  let(:graphql_context) { {} }
  let(:graphql_result) { subject.resolve(nil, graphql_args, graphql_context) }
  let!(:entry) { create(:entry) }
  let(:args) { { entry_id: entry_graph_id } }

  context "success" do
    let(:entry_graph_id) { GraphQL::Relay::GlobalNodeIdentification.new.to_global_id("Entry", entry.id) }

    it "deletes the entry if the entry exists" do
      expect { graphql_result }.to change(Entry, :count).from(1).to(0)
    end
  end

  context "failure" do
    let(:entry_graph_id) { GraphQL::Relay::GlobalNodeIdentification.new.to_global_id("Entry", 999) }

    it "does not delete a non-existant entry" do
      expect { graphql_result }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end

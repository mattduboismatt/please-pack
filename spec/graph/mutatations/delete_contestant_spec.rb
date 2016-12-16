require "rails_helper"

RSpec.describe Mutations::DeleteContestant do
  subject { Mutations::DeleteContestant.field }
  let(:graphql_args) { GraphQL::Query::Arguments.new(input: args.merge(clientMutationId: "0")) }
  let(:graphql_context) { {} }
  let(:graphql_result) { subject.resolve(nil, graphql_args, graphql_context) }
  let!(:contestant) { create(:contestant) }
  let(:args) { { contestant_id: contestant_graph_id } }

  context "success" do
    let(:contestant_graph_id) { GraphQL::Relay::GlobalNodeIdentification.new.to_global_id("Contestant", contestant.id) }

    it "deletes the contestant if the contestant exists" do
      expect { graphql_result }.to change(Contestant, :count).from(1).to(0)
    end
  end

  context "failure" do
    let(:contestant_graph_id) { GraphQL::Relay::GlobalNodeIdentification.new.to_global_id("Contestant", 999) }

    it "does not delete a non-existant contestant" do
      expect { graphql_result }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end

require "rails_helper"

RSpec.describe Mutations::CreateContestant do
  subject { Mutations::CreateContestant.field }
  let(:graphql_args) { GraphQL::Query::Arguments.new(input: args.merge(clientMutationId: "0")) }
  let(:graphql_context) { {} }
  let(:graphql_result) { subject.resolve(nil, graphql_args, graphql_context) }
  let(:args) { attributes_for(:contestant) }
  let(:pool) { create(:pool) }
  let(:pool_graph_id) { GraphQL::Relay::GlobalNodeIdentification.new.to_global_id("Pool", pool.id) }

  context "with a pool" do
    before { args[:pool_id] = pool_graph_id }

    it "creates a contestant for that pool" do
      expect { graphql_result }.to change(pool.reload.contestants, :count).from(0).to(1)
      contestant = Contestant.last
      expect(contestant.pool).to eq pool
      expect(contestant.first_name).to eq args[:first_name]
      expect(contestant.last_name).to eq args[:last_name]
      expect(contestant.residence).to eq args[:residence]
      expect(contestant.description).to eq args[:description]
    end

    it "raises an error if invalid inputs are supplied" do
      args[:first_name] = ""
      expect { graphql_result }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end

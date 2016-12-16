require "rails_helper"

RSpec.describe Mutations::DeletePool do
  subject { Mutations::DeletePool.field }
  let(:graphql_args) { GraphQL::Query::Arguments.new(input: args.merge(clientMutationId: "0")) }
  let(:graphql_context) { {} }
  let(:graphql_result) { subject.resolve(nil, graphql_args, graphql_context) }
  let!(:pool) { create(:pool) }
  let(:args) { { pool_id: pool_graph_id } }

  context "success" do
    let(:pool_graph_id) { GraphQL::Relay::GlobalNodeIdentification.new.to_global_id("Pool", pool.id) }

    it "deletes the pool if the pool exists" do
      expect { graphql_result }.to change(Pool, :count).from(1).to(0)
    end

    it "deletes the entries and contestants for that pool" do
      create_list(:entry, 2, pool: pool)
      create_list(:contestant, 2, pool: pool)
      expect { graphql_result }.to change(Entry, :count).from(2).to(0)
        .and change(Contestant, :count).from(2).to(0)
    end
  end

  context "failure" do
    let(:pool_graph_id) { GraphQL::Relay::GlobalNodeIdentification.new.to_global_id("Pool", 999) }

    it "does not delete a non-existant pool" do
      expect { graphql_result }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end

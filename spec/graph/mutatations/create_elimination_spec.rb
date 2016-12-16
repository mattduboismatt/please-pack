require "rails_helper"

RSpec.describe Mutations::CreateElimination do
  subject { Mutations::CreateElimination.field }
  let(:graphql_args) { GraphQL::Query::Arguments.new(input: args.merge(clientMutationId: "0")) }
  let(:graphql_context) { {} }
  let(:graphql_result) { subject.resolve(nil, graphql_args, graphql_context) }
  let(:pool) { create(:pool) }
  let!(:contestants) { create_list(:contestant, 2, pool: pool) }
  let!(:contestant_for_elimination) { create(:contestant, pool: pool) }
  let!(:eliminated_contestant) { create(:contestant, :eliminated, pool: pool) }
  let(:points) { (1..10).to_a.sample }
  let(:args) do
    {
      pool_id: pool.id,
      points: points,
      contestant_ids: [contestant_for_elimination.id]
    }
  end

  context "success" do
    it "creates an advancement score with points for all active contestants" do
      expect { graphql_result }.to change(Score, :count).from(0).to(1)
      score = Score.last
      expect(score.points).to eq points
      expect(score.mechanism).to eq Score::MECHANISMS::ADVANCEMENT
      expect(score.contestants).to match_array contestants
      expect(contestants.sample.reload.points).to eq points
    end

    it "marks the contestant as eliminated" do
      expect(contestant_for_elimination.eliminated?).to eq false
      graphql_result
      expect(contestant_for_elimination.reload.eliminated?).to eq true
    end
  end

  context "failure" do
    it "does not create a score with zero or negative" do
      args[:points] = 0
      expect { graphql_result }.to raise_error(ActiveRecord::RecordInvalid, /points must be greater than 0/i)
    end

    it "does not create a score if a contestant is re-eliminated" do
      args[:contestant_ids] = [eliminated_contestant.id]
      expect { graphql_result }.to raise_error(GraphQL::ExecutionError, /contestant has already been eliminated/i)
    end

    it "does not create a score without contestants" do
      args[:contestant_ids] = []
      expect { graphql_result }.to raise_error(GraphQL::ExecutionError, /contestants must not be empty/i)
    end
  end
end

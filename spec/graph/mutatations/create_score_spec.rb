require "rails_helper"

RSpec.describe Mutations::CreateScore do
  subject { Mutations::CreateScore.field }
  let(:graphql_args) { GraphQL::Query::Arguments.new(input: args.merge(clientMutationId: "0")) }
  let(:graphql_context) { {} }
  let(:graphql_result) { subject.resolve(nil, graphql_args, graphql_context) }
  let!(:contestants) { create_list(:contestant, 2, pool: create(:pool)) }
  let!(:other_contestant) { create(:contestant) }
  let(:args) do
    {
      points: points,
      mechanism: mechanism,
      contestant_ids: contestant_ids
    }
  end
  let(:points) { (1..10).to_a.sample }
  let(:mechanism) { Score::MECHANISMS.all.sample }
  let(:contestant_ids) { contestants.map(&:id) }

  context "success" do
    it "creates a score with points, a mechanism, and contestants" do
      expect { graphql_result }.to change(Score, :count).from(0).to(1)
      score = Score.last
      expect(score.points).to eq points
      expect(score.mechanism).to eq mechanism
      expect(score.contestants).to match_array contestants
    end
  end

  context "failure" do
    it "does not create a score with negative points" do
      args[:points] = -9
      expect { graphql_result }.to raise_error(ActiveRecord::RecordInvalid, /points must be greater than 0/i)
    end

    it "does not create a score with invalid mechanism" do
      args[:mechanism] = "avoid one-off scoring"
      expect { graphql_result }.to raise_error(ActiveRecord::RecordInvalid, /mechanism is not included in the list/i)
    end

    it "does not create a score without contestants" do
      args[:contestant_ids] = []
      expect { graphql_result }.to raise_error(GraphQL::ExecutionError, /contestants must not be empty/i)
    end

    it "does not create a score if unknown contestants are supplied" do
      args[:contestant_ids] = contestant_ids.push(9999)
      expect { graphql_result }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end

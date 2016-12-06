require "rails_helper"

RSpec.describe Mutations::SavePicks do
  subject { Mutations::SavePicks.field }
  let(:graphql_args) { GraphQL::Query::Arguments.new(input: args.merge(clientMutationId: "0")) }
  let(:graphql_context) { {} }
  let(:graphql_result) { subject.resolve(nil, graphql_args, graphql_context) }
  let(:args) { { entry_id: entry.id } }
  let(:entry) { create(:entry) }
  let(:pool) { entry.pool }

  context "adding new picks" do
    let!(:other_contestant) { create(:contestant, pool: pool) }
    let!(:contestants) { create_list(:contestant, 2, pool: pool) }

    before { args[:contestant_ids] = contestants.map(&:id) }

    it "creates a pick for each contestant id input" do
      expect { graphql_result }.to change(entry.reload.picks, :count).from(0).to(2)
      pick = Pick.last
      expect(pick.entry).to eq entry
      expect(contestants).to include(pick.contestant)
    end
  end

  context "resaving all picks" do
    let!(:picks) { create_list(:pick, 3, entry: entry, pool: pool) }

    before { args[:contestant_ids] = picks.map { |pick| pick.contestant.id } }

    it "does not change any picks" do
      expect { graphql_result }.to_not change(entry.reload.picks, :count)
      expect(entry.picks).to match_array picks
    end
  end

  context "removing all picks" do
    let!(:picks) { create_list(:pick, 3, entry: entry, pool: pool) }
    let!(:other_pick) { create(:pick, contestant: picks.sample.contestant, pool: pool) }

    before { args[:contestant_ids] = [] }

    it "deletes all picks for that entry" do
      expect { graphql_result }.to change(entry.reload.picks, :count).from(3).to(0)
      expect(Pick.all).to match_array [other_pick]
    end
  end

  context "adding and removing some picks" do
    let!(:picks_to_keep) { create_list(:pick, 2, entry: entry, pool: pool) }
    let!(:picks_to_remove) { create_list(:pick, 2, entry: entry, pool: pool) }
    let(:contestant_to_add) { create(:contestant, pool: pool) }
    let(:contestant_ids) { picks_to_keep.map { |pick| pick.contestant.id } + [contestant_to_add.id] }

    before { args[:contestant_ids] = contestant_ids }

    it "does not delete picks where contestant id is included" do
      expect { graphql_result }.to change(entry.reload.picks, :count).from(4).to(3)
      new_pick = Pick.last
      expect(new_pick.contestant).to eq contestant_to_add
      expect(entry.picks).to match_array(picks_to_keep + [new_pick])
    end
  end
end

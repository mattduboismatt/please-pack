require "rails_helper"

RSpec.describe "Pool Standings", js: true do
  let!(:pool) { create(:pool) }
  let!(:entry) { create(:entry, pool: pool) }

  describe "summary" do
    let!(:conte) { create(:contestant, pool: pool) }

    before { visit "/pools/#{pool.id}" }

    it "displays the pool title" do
      expect(page).to have_text(/#{pool.title}/i)
      expect(page).to have_text(/standings/i)
    end

    it "does not display admin capabalities" do
      expect(page).to_not have_css(".create-contestant")
      expect(page).to_not have_css(".create-entry")

      within(".entries-list") do
        expect(page).to_not have_css("a.admin-link")
      end

      within(".contestants-list") do
        expect(page).to_not have_css("a.admin-link")
      end
    end
  end

  describe "entries" do
    it "displays the pool entries sorted by points" do
      entry2 = create(:entry, :with_points, pool: pool)
      visit "/pools/#{pool.id}"

      within(".entries-list") do
        expect(all(".entry").count).to eq 2
        first_place = all(".entry")[0]
        expect(first_place.find(".name").text).to eq entry2.name
        expect(first_place.find(".points").text).to eq entry2.points.to_s

        second_place = all(".entry")[1]
        expect(second_place.find(".name").text).to eq entry.name
        expect(second_place.find(".points").text).to eq entry.points.to_s
      end
    end

    it "has a link to display the entry picks, sorted by points" do
      pick1 = create(:pick, entry: entry)
      pick2 = create(:pick, entry: entry)
      contestant1 = pick1.contestant
      contestant2 = pick2.contestant
      create(:contestant_score, contestant: contestant1, score: create(:score, points: 1))
      create(:contestant_score, contestant: contestant2, score: create(:score, points: 9))

      visit "/pools/#{pool.id}"
      within(".entries-list") do
        expect(all(".pick").count).to eq 0
        find(".entry").click
        expect(all(".pick").count).to eq 2

        first_place = all(".pick")[0]
        expect(first_place.find(".first-name").text).to eq contestant2.first_name
        expect(first_place.find(".points").text).to eq contestant2.points.to_s

        second_place = all(".pick")[1]
        expect(second_place.find(".first-name").text).to eq contestant1.first_name
        expect(second_place.find(".points").text).to eq contestant1.points.to_s
      end
    end
  end

  describe "contestants" do
    let(:contestant) { create(:contestant, pool: pool) }
    let(:other_contestant) { create(:contestant, pool: pool) }

    before do
      create(:contestant_score, contestant: other_contestant, score: create(:score, points: 5))
      create(:contestant_score, contestant: contestant, score: create(:score, points: 100))
    end

    it "displays the pool contestants sorted by points" do
      visit "/pools/#{pool.id}"

      within(".contestants-list") do
        expect(all(".contestant").count).to eq 2
        first_place = all(".contestant")[0]
        expect(first_place.find(".first-name").text).to eq contestant.first_name
        expect(first_place.find(".points").text).to eq contestant.points.to_s

        second_place = all(".contestant")[1]
        expect(second_place.find(".first-name").text).to eq other_contestant.first_name
        expect(second_place.find(".points").text).to eq other_contestant.points.to_s
      end
    end

    it "marks eliminated contestants" do
      contestant.eliminate!
      visit "/pools/#{pool.id}"
      eliminated_contestant = find(".contestant.eliminated")
      expect(eliminated_contestant.text).to match(/#{contestant.first_name}/i)
    end
  end
end

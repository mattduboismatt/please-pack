require "rails_helper"

RSpec.describe "Setting up a pool", js: true do
  let(:pool) { create(:pool) }
  let!(:contestants) { create_list(:contestant, 3, pool: pool) }
  let!(:other_contestant) { create(:contestant) }
  let!(:entries) { create_list(:entry, 3, pool: pool) }
  let!(:other_entry) { create(:entry) }

  before { visit "/pools/#{pool.id}/setup" }

  describe "contestants" do
    it "displays a list of the contestants" do
      within(".contestants-list") do
        expect(all(".contestant").count).to eq contestants.count
        expect(all("a.remove").count).to eq contestants.count
        contestants.each do |contestant|
          expect(page).to have_text contestant.first_name
        end
      end
    end

    describe "adding a contestant" do
      let(:args) { attributes_for(:contestant) }

      context "successfully" do
        it "appends the contestant to the list and clears the form" do
          within(".create-contestant") do
            fill_in "first_name", with: args[:first_name]
            fill_in "last_name", with: args[:last_name]
            fill_in "residence", with: args[:residence]
            fill_in "description", with: args[:description]
            click_button "Create Contestant"
          end
          within(".contestants-list") do
            expect(page).to have_text args[:first_name]
          end
          within(".create-contestant") do
            expect(find("input#first_name").value).to eq ""
          end
        end
      end

      context "unsuccessfully" do
        xit "displays an error message"
      end
    end

    describe "removing a contestant" do
      let(:entry) { entries.last }
      let(:contestant) { contestants.last }
      let!(:pick) { create(:pick, entry: entry, contestant: contestant) }
      let!(:contestant_score) { create(:contestant_score, contestant: contestant, score: create(:score, points: 5)) }

      it "removes the contestant from the pool and updates entry scores appropriately" do
        visit "/pools/#{pool.id}/setup"
        entry_points = find(".entry", text: /#{entry.name}/i).find(".points")
        expect(entry_points.text).to eq "5"
        expect(page).to have_text contestant.first_name
        remove_contestant_link = find(".contestant", text: /#{contestant.first_name}/i).find("a.remove")
        expect do
          remove_contestant_link.click
          sleep 1
        end.to change(pool.reload.contestants, :count).by(-1)

        expect(page).to_not have_text contestant.first_name
        expect(page).to have_text contestants.first.first_name
        expect(entry_points.text).to eq "0"
      end

      xit "uses a confirm box to ensure the action"
    end
  end

  describe "entries" do
    it "displays a list of the entries" do
      within(".entries-list") do
        expect(all(".entry").count).to eq entries.count
        expect(all("a.admin-link", text: /remove/i).count).to eq entries.count
        entries.each do |entry|
          expect(page).to have_text entry.name
          expect(page).to have_text entry.points
          expect(page).to have_link(text: "Make Picks", href: "/entries/#{entry.id}/picks")
        end
      end

      entry = entries.first
      link = find(:css, "a.admin-link[href='/entries/#{entry.id}/picks']")
      link.click
      expect(page).to have_text(/#{entry.name} - #{entry.points} points/i)
    end

    describe "adding an entry" do
      let(:entry_name) { "The Champ" }

      context "successfully" do
        it "appends the entry to the list and clears the form" do
          within(".create-entry") do
            fill_in "entry_name", with: entry_name
            click_button "Create Entry"
          end
          within(".entries-list") do
            expect(page).to have_text entry_name
          end
          within(".create-entry") do
            expect(find("input#entry_name").value).to eq ""
          end
        end
      end

      context "unsuccessfully" do
        xit "displays an error message"
      end
    end

    describe "removing an entry" do
      let(:entry) { entries.first }

      it "removes the entry from the pool" do
        expect(page).to have_text entry.name
        entry_row = find("a[href='/entries/#{entry.id}/picks']").first(:xpath, ".//..")
        expect do
          entry_row.find("a.remove").click
          sleep 1
        end.to change(pool.reload.entries, :count).by(-1)

        expect(page).to_not have_text entry.name
        expect(page).to have_text entries.last.name
      end

      xit "uses a confirm box to ensure the action"
    end
  end
end

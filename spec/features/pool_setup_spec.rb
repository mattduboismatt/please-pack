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
  end

  describe "entries" do
    it "displays a list of the entries" do
      within(".entries-list") do
        expect(all(".entry").count).to eq entries.count
        entries.each do |entry|
          expect(page).to have_text entry.name
          expect(page).to have_text entry.points
          expect(page).to have_link(text: "Make Picks", href: "/entries/#{entry.id}/picks")
        end
      end

      all(".make-picks").first.click
      expect(page).to have_text "Entry:"
      expect(page).to have_text "Points:"
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
  end
end

require "rails_helper"

RSpec.describe "Entry Picks", js: true do
  let!(:entry) { create(:entry) }
  let!(:contestants) { create_list(:contestant, 3, pool: entry.pool) }
  let!(:other_contestant) { create(:contestant) }
  let(:contestant) { contestants.last }
  let!(:pick) { create(:pick, entry: entry, contestant: contestant) }

  before { visit "/entries/#{entry.id}/picks" }

  it "displays the entry name and points" do
    within(".entry") do
      expect(page).to have_text("Entry: #{entry.name}")
      expect(page).to have_text("Points: #{entry.points}")
    end
  end

  it "displays a form for selecting contestants within that pool" do
    within(".entry .picks") do
      expect(all("input[type='checkbox']").count).to eq contestants.count
      contestants.each do |contestant|
        expect(page).to have_text(contestant.first_name)
        expect(page).to have_css("input[value='#{contestant.first_name}']")
      end
    end
  end

  describe "saving picks" do
    it "adds a pick if a contestant is selected" do
      new_contestant = contestants.first
      checkbox = find("input[value='#{new_contestant.first_name}']")
      expect(checkbox.checked?).to eq false
      checkbox.click
      click_button "Save"
      visit "/entries/#{entry.id}/picks"
      expect(checkbox.checked?).to eq true
    end

    it "removes a pick if contestant is deselected" do
      checkbox = find("input[value='#{contestant.first_name}']")
      expect(checkbox.checked?).to eq true
      checkbox.click
      click_button "Save"
      visit "/entries/#{entry.id}/picks"
      expect(checkbox.checked?).to eq false
    end

    it "redirects to the pool setup page" do
      click_button "Save"
      expect(page).to have_text "Setup"
    end
  end
end

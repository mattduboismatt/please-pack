require "rails_helper"

RSpec.describe "Entry Picks", js: true do
  let(:entry) { create(:entry) }
  let!(:contestants) { create_list(:contestant, 3, pool: entry.pool) }
  let!(:other_contestant) { create(:contestant) }

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
end

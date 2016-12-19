require "rails_helper"

RSpec.describe "Entry Picks", js: true do
  let!(:entry) { create(:entry) }
  let!(:contestants) { create_list(:contestant, 3, pool: entry.pool) }
  let!(:other_contestant) { create(:contestant) }
  let(:contestant) { contestants.last }
  let!(:pick) { create(:pick, entry: entry, contestant: contestant) }

  before { visit "/entries/#{entry.id}/picks" }

  it "displays the entry name and points" do
    within(".entry-picks") do
      expect(page).to have_text(/#{entry.name} - #{entry.points} points/i)
    end
  end

  it "displays a form for selecting contestants within that pool" do
    within(".entry-picks .picks") do
      expect(all("input[type='checkbox']", visible: false).count).to eq contestants.count
      contestants.each do |contestant|
        expect(page).to have_text(contestant.first_name)
        expect(page).to have_css("input[value='#{contestant.first_name}']", visible: false)
      end
    end
  end

  it "marks contestants as elimianted" do
    eliminated_contestant = contestants.last
    eliminated_contestant.update!(eliminated: true)
    visit "/entries/#{entry.id}/picks"
    eliminated_label = find("label.eliminated")
    expect(eliminated_label.text).to match(/#{eliminated_contestant.first_name}/i)
  end

  describe "saving picks" do
    it "adds a pick if a contestant is selected" do
      new_contestant = contestants.first
      label = find("label", text: new_contestant.first_name)
      expect(label[:class]).to eq ""
      label.click
      click_button "Save"
      visit "/entries/#{entry.id}/picks"

      label = find("label", text: new_contestant.first_name)
      expect(label[:class]).to eq "selected"
    end

    it "removes a pick if contestant is deselected" do
      label = find("label", text: contestant.first_name)
      expect(label[:class]).to eq "selected"
      label.click
      click_button "Save"
      visit "/entries/#{entry.id}/picks"

      label = find("label", text: contestant.first_name)
      expect(label[:class]).to eq ""
    end

    it "redirects to the pool setup page" do
      click_button "Save"
      expect(page).to have_text "Setup"
    end
  end
end

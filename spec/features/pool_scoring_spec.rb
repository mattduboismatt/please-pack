require "rails_helper"

RSpec.describe "Scoring a pool", js: true do
  let(:pool) { create(:pool) }
  let!(:contestants) { create_list(:contestant, 3, pool: pool) }
  let!(:other_contestant) { create(:contestant) }

  before { visit "/pools/#{pool.id}/score" }

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
require "rails_helper"

RSpec.describe "Pool Scoring", js: true do
  let(:pool) { create(:pool) }
  let!(:contestants) { create_list(:contestant, 3, pool: pool) }
  let!(:other_contestant) { create(:contestant) }

  before { visit "/pools/#{pool.id}/score" }

  it "displays the pool title" do
    visit "/pools/#{pool.id}/score"
    within(".pool") do
      expect(page).to have_text(/#{pool.title}/i)
    end
  end

  it "displays a form for selecting contestants within that pool" do
    within(".pool .scoring") do
      all_checkboxes = all("input[type='checkbox']", visible: false)
      expect(all_checkboxes.count).to eq contestants.count
      all_checkboxes.each do |checkbox|
        expect(checkbox.checked?).to eq false
      end

      contestants.each do |contestant|
        expect(page).to have_text(/#{contestant.first_name}/i)
        expect(page).to have_css("input[value='#{contestant.first_name}']", visible: false)
      end

      expect(find("input[name='points']").value).to eq "1"
      within("select[name='score_mechanism']") do
        expect(all("option").count).to eq Score::MECHANISMS.all.count
        Score::MECHANISMS.all.each do |mechanism|
          find("option[value='#{mechanism}']")
        end
      end
    end
  end

  describe "creating a score" do
    let(:contestant1) { contestants.first }
    let(:contestant2) { contestants.second }
    let(:contestant3) { contestants.third }
    let(:points) { (1..10).to_a.sample }
    let(:mechanism) { Score::MECHANISMS.all.sample }

    it "creates a score and adds each contestant that was selected and redirects to the admin panel" do
      find("label", text: contestant1.first_name).click
      find("label", text: contestant3.first_name).click
      fill_in "points", with: points
      select(mechanism, from: "score_mechanism")

      click_button "Score"
      expect(page).to have_text "Super Secret Admin Panel"
      expect(contestant1.reload.points).to eq points
      expect(contestant3.reload.points).to eq points
      expect(contestant2.reload.points).to eq 0
      expect(contestant1.scores.last.mechanism).to eq mechanism
    end

    context "unsuccessfully" do
      xit "displays an error message when no contestants have been selected" do
      end

      xit "displays an error message when negative points have been entered" do
      end
    end
  end
end

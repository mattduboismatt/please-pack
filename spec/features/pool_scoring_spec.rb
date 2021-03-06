require "rails_helper"

RSpec.describe "Pool Scoring", js: true do
  let(:pool) { create(:pool) }
  let!(:contestants) { create_list(:contestant, 3, pool: pool) }
  let(:contestant1) { contestants.first }
  let(:contestant2) { contestants.second }
  let(:contestant3) { contestants.third }
  let!(:other_contestant) { create(:contestant) }

  before { visit "/pools/#{pool.id}/score" }

  it "displays the pool title and admin links" do
    within(".pool") do
      expect(page).to have_text(/#{pool.title}/i)
    end
    pool_id = pool.id
    within(".pool-admin-links") do
      expect(page).to have_link("Standings", href: "/pools/#{pool_id}")
      expect(page).to have_link("Setup", href: "/pools/#{pool_id}/setup")
      expect(page).to have_link("Score", href: "/pools/#{pool_id}/score")
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
        expect(all("option").count).to eq(Score::MECHANISMS.top_chef.count + 1) # including placeholder option
        Score::MECHANISMS.top_chef.each do |mechanism|
          find("option[value='#{mechanism}']")
        end
      end
    end
  end

  it "marks eliminated contestants" do
    contestant1 = contestants.first
    contestant1.eliminate!
    visit "/pools/#{pool.id}/score"

    eliminated_contestant = find("label.eliminated")
    expect(eliminated_contestant.text).to match(/#{contestant1.first_name}/i)
  end

  describe "creating a score" do
    let(:points) { (1..10).to_a.sample }

    context "non elmination" do
      let(:mechanism) { [Score::MECHANISMS::QUICKFIRE, Score::MECHANISMS::WEEKLY_WINNER].sample }

      it "creates a score and adds each contestant that was selected and redirects to the admin panel" do
        find("label", text: contestant1.first_name).click
        find("label", text: contestant3.first_name).click
        fill_in "points", with: points
        select(mechanism, from: "score_mechanism")

        click_button "Score"
        find("h2", text: /super secret admin panel/i).click
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

    context "elimination" do
      let(:mechanism) { Score::MECHANISMS::ELIMINATION }

      it "creates an advancement score for all non-selected contestants and marks the selected contestant as elminated" do
        find("label", text: /#{contestant2.first_name}/i).click
        fill_in "points", with: points
        select(mechanism, from: "score_mechanism")

        click_button "Score"
        find("h2", text: /super secret admin panel/i).click
        score = Score.last
        expect(score.points).to eq points
        expect(score.mechanism).to eq Score::MECHANISMS::ADVANCEMENT
        expect(score.contestants).to match_array [contestant1, contestant3]
        expect(contestant2.reload.eliminated?).to eq true
      end
    end
  end
end

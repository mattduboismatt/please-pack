require "rails_helper"

RSpec.describe "Homepage", js: true do
  it "displays the welcome message" do
    visit "/"
    expect(page).to have_text(/please pack your knives/i)
    expect(page).to have_text(/pools!/i)
  end

  it "displays a list of pools" do
    pool = create(:pool)
    other_pool = create(:pool)

    visit "/"
    within(".pools-list") do
      expect(all(".pool").count).to eq 2
      expect(page).to have_link(text: /#{pool.title}/i, href: "/pools/#{pool.id}")
      expect(page).to have_link(text: /#{other_pool.title}/i, href: "/pools/#{other_pool.id}")
    end

    click_link(pool.title)
    expect(page).to have_text(/standings/i)
  end

  it "falls back to an empty page" do
    visit "/foobar"
    expect(page).to have_text(/please pack your knives/i)
  end
end

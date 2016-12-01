require "rails_helper"

RSpec.describe "Admin Panel", js: true do
  it "displays the welcome message" do
    visit "/admin"
    expect(page).to have_text(/super secret admin panel/i)
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

  it "displays a link to score the pool" do
    pool = create(:pool)

    visit "/admin"
    expect(page).to have_link("Score", href: "/pools/#{pool.id}/score")
  end
end

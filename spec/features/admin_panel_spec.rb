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

  it "displays a link to setup and to score the pool" do
    pool = create(:pool)

    visit "/admin"
    expect(page).to have_link("Setup", href: "/pools/#{pool.id}/setup")
    expect(page).to have_link("Score", href: "/pools/#{pool.id}/score")
  end

  describe "adding a pool" do
    context "successfully" do
      it "appends the pool to the list" do
        pool_title = "So you think you can refactor?"

        visit "/admin"
        fill_in "pool_title", with: pool_title
        click_button "Create Pool"
        expect(page).to have_link(pool_title)
      end
    end

    context "unsuccessfully" do
      xit "displays an error message"
    end
  end
end

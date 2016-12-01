require "rails_helper"

RSpec.describe "Homepage", js: true do
  it "displays the welcome message" do
    visit "/"
    expect(page).to have_text(/please pack your knives/i)
    expect(page).to have_text(/pools!/i)
  end

  it "falls back to an empty page" do
    visit "/foobar"
    expect(page).to have_text(/please pack your knives/i)
  end
end

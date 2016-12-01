require "rails_helper"

RSpec.describe "Admin Panel", js: true do
  it "displays the welcome message" do
    visit "/admin"
    expect(page).to have_text(/super secret admin panel/i)
  end
end

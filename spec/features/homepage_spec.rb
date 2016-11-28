require "rails_helper"

RSpec.describe "Homepage" do
  it "displays the welcome message" do
    visit root_path
    expect(page).to have_text(/please pack your knives/i)
  end
end

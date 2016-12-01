require "rails_helper"

RSpec.describe "Pool Standings", js: true do
  let(:pool) { create(:pool) }

  it "displays the pool title" do
    visit "/pools/#{pool.id}"

    expect(page).to have_text(/#{pool.title}/i)
    expect(page).to have_text(/standings/i)
  end
end

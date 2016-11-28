require "rails_helper"

RSpec.describe HomeController do
  describe "index" do
    it "renders the home page" do
      get :index
      expect(response).to be_success
    end
  end
end

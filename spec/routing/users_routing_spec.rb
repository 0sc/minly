require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/dashboard").to route_to("users#index")
    end
  end
end

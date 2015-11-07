require "rails_helper"

RSpec.describe SessionsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:get => "/auth/facebook/callback").to route_to("sessions#create", provider: "facebook")
    end

    it "routes to #destroy" do
      expect(:get => "/signout").to route_to("sessions#destroy")
    end
  end
end

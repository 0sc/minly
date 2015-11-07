require "rails_helper"

RSpec.describe Api::V1::RequestsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(:get => "/api/v1/requests/show/popular/shortened/12345").to route_to("api/v1/requests#show", format: "json", target: "popular", short_url: "shortened", user_token: "12345")
      expect(:get => "/api/v1/requests/show/recent/shortened/12345").to route_to("api/v1/requests#show", format: "json", target: "recent", short_url: "shortened", user_token: "12345")
      expect(:get => "/api/v1/requests/show/expand/shortened/12345").to route_to("api/v1/requests#show", format: "json", target: "expand", short_url: "shortened", user_token: "12345")
    end
  end
end

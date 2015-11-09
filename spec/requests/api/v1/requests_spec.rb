require 'rails_helper'

RSpec.describe "Api::V1::RequestsController", type: :request do
  describe "GET /show" do
    it "accepts json requests for popular minlys" do
      get api_v1_path("popular"), {}, { accept: "application/json" }
      expect(response.status).to eq 200
    end
    it "accepts json requests for recent minlys" do
      get api_v1_path("recent"), {}, { accept: "application/json" }
      expect(response.status).to eq 200
    end
    it "accepts json requests to fetch original of given minly" do
      get api_v1_path("expand"), {}, { accept: "application/json" }
      expect(response.status).to eq 200
    end

    context "popular minlys" do
      it "returns five popular minlys for valid request params" do
        10.times { create(:url) }
        url = create(:url, views: 100000).to_json

        get api_v1_path("popular"), {} , { accept: "application/json" }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body["status"]).to eq "success"
        expect(body["payload"].size).to eq 5
        expect(body["payload"].first).to eq JSON.parse url
      end

      it "returns error message if no result" do
        get api_v1_path("popular"), {} , { accept: "application/json" }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body["status"]).to eq "error"
        expect(body["payload"].size).to eq 0
      end
    end

    context "Recent minlys" do
      it "returns five recent minlys for valid request params" do
        10.times { create(:url) }
        url = create(:url).to_json

        get api_v1_path("recent"), {} , { accept: "application/json" }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body["status"]).to eq "success"
        expect(body["payload"].size).to eq 5
        expect(body["payload"].first).to eq JSON.parse url
      end

      it "returns error message if no result" do
        get api_v1_path("recent"), {} , { accept: "application/json" }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body["status"]).to eq "error"
        expect(body["payload"].size).to eq 0
      end
    end

    context "expand minlys" do
      it "returns the information of a given valid minly" do
        url = create(:url, shortened: "ly").to_json

        get api_v1_path("expand"), {short_url: "ly"} , { accept: "application/json" }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body["status"]).to eq "success"
        expect(body["payload"]).to eq JSON.parse url
      end

      it "returns error message if no result" do
        url = create(:url, shortened: "ly").to_json

        get api_v1_path("expand"), {short_url: ""} , { accept: "application/json" }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body["status"]).to eq "error"
        expect(body["payload"].size).to eq 0
      end
    end
  end
end

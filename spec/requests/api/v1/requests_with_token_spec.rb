require 'rails_helper'

def make_post_request(params, url="/urls")
  post url, params, { accept: "application/json" }
  expect(response.status).to eq 200
  JSON.parse(response.body)
end

def make_patch_request(params)
  put "/urls/test.json", params, { accept: "application/json" }
  expect(response.status).to eq 200
  JSON.parse(response.body)
end

RSpec.describe "Api::V1::RequestsController", type: :request do
  describe "Requests with token" do

    context "create minly" do
      before(:each) do
        create(:user, token: 12345)
        @params = {
          "url[original]" => "http://shielded.com/polasimer",
          "user_token" => 12345,
          "url[shortened]" => "test"
        }
      end
      it "process create request with valid token and valid params" do
        body = make_post_request @params
        expect(body["status"]).to eq "success"
        expect(body["payload"]["original"]).to eq "http://shielded.com/polasimer"
      end

      it "doesn't process request with invalid params" do
        @params["url[original]"] = "httP.56.com|=9()"
        body = make_post_request @params
        expect(body["status"]).to eq "error"
        expect(body["payload"]["created_at"]).to be nil
      end
      it "process request with invalid token as that of regular users" do
        @params["user_token"] = "6$4343"
        body = make_post_request @params
        expect(body["payload"]["shortened"]).not_to be "test"
      end
    end

    context "update minly original url" do
      before(:each) do
        create(:user, token: 12345)
        @params = {
          "url[original]" => "http://shielded.com/polasimer",
          "user_token" => 12345,
        }
        create(:url, shortened: "test", original: "http://another.com")
      end

      it "process update request with valid token and valid params" do
        body = make_patch_request(@params)
        expect(body["status"]).to eq "success"
        expect(body["payload"]["original"]).to eq "http://shielded.com/polasimer"
      end

      it "doesn't process request with invalid params" do
        @params["url[original]"] = "httP.56.com|=9()"
        body = make_patch_request(@params)
        expect(body["status"]).to eq "error"
        # expect(body["payload"]["original"]).not_to eq "http://another.com"
      end

      it "doesn't process request with invalid token" do
        @params["user_token"] = 54321
        body = make_patch_request(@params)
        expect(body["status"]).to eq "error"
        expect(body["payload"]).to be nil
      end
    end

  end
end

require 'rails_helper'

def make_post_request(params)
  post "/urls", params, { accept: "application/json" }
  expect(response.status).to eq 200
  binding.pry
  JSON.parse(response.body)
end

RSpec.describe "Api::V1::RequestsController", type: :request do
  describe "Requests with token" do
    before(:each) do
      create(:user, token: 12345)
      @params = {
        "url[shortened]" => Faker::Internet.url,
        "url[original]" => Faker::Lorem.word,
        "user_token" => 12345
      }
    end

    context "create minly" do
      it "process create request with valid token and valid params" do
        body = make_post_request @params
        expect(body["status"]).to eq "success"
        expect(body["payload"]).to eq JSON.parse url
      end

      it "doesn't process request with invalid params" do
        @params["url[original]"] = "httP.56.com|=9()"
        body = make_post_request @params
        expect(body["status"]).to eq "error"
        expect(body["payload"]).to be_empty
      end
      it "doesn't process request with invalid token" do
        @params["url[original]"] = "httP.56.com|=9()"
        body = make_post_request @params
        expect(body["status"]).to eq "error"
        expect(body["payload"]).to be_empty
      end
    end


  end
end

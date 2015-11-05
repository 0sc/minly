require 'rails_helper'
require "helpers/omniauth_helper"

RSpec.describe User, type: :model do
  describe "#from_omniauth" do
    it "creates users from valid OmniAuth response"do
      user = User.from_omniauth(set_valid_omniauth)
      expect(user).to be_instance_of User
      expect(User.first).to eq user
    end

    it "doesn't not create users for invalid OmniAuth response" do
      expect(User.from_omniauth(set_invalid_omniauth)).not_to be_instance_of User
      expect(User.from_omniauth(set_invalid_omniauth)).to be false
    end
  end

  describe "#get_urls" do
    it "returns all the url of the given user" do
      user = create(:user)
      expect(user.get_urls.size).to eql 0

      last = create(:registered_users_url, user_id: user.id)
      5.times { create(:registered_users_url, user_id: user.id) }
      first = create(:registered_users_url, user_id: user.id)

      expect(user.get_urls.size).to eq 7
      expect(user.get_urls.first).to eq first
      expect(user.get_urls.last).to eq last
    end
  end

  describe "#search_url_for" do
    before(:each) do
      @user = create(:user)
      @url = create(:registered_users_url, user_id: @user.id, shortened: "go")
    end

    it "returns the url of the current user that matchs the given id" do
      expect(@user.search_url_for(1, :id).size).to eql 1
      expect(@user.search_url_for(1, :id).first).to eql @url
    end

    it "returns the url of the current user that matchs the given shortened url" do
      expect(@user.search_url_for("go", :shortened).size).to eql 1
      expect(@user.search_url_for("go", :shortened).first).to eql @url
    end

    it "returns nil if given params doesn't match any user data" do
      expect(@user.search_url_for("god", :shortened).size).to eq 0
      expect(@user.search_url_for(65).size).to eql 0
    end

    it "throws an error if called with wrong arguments" do
      expect {@user.search_url_for}.to raise_error(ArgumentError)
      expect {@user.search_url_for("one", "two", "three")}.to raise_error(ArgumentError)
    end
  end

  describe "#get_user" do
    before(:each) do
      @user = create(:user, token: 123456)
    end

    it "returns the user object of the give user_id" do
      expect(User.get_user(1)).to eq @user
    end

    it "returns the user object of the given user token" do
      expect(User.get_user(123456, :token)).to eq @user
    end

    it "returns nil if user is not found" do
      expect(User.get_user(4)).to be_nil
    end

    it "throws an error if called with wrong arguments" do
      expect {@user.search_url_for}.to raise_error(ArgumentError)
      expect {@user.search_url_for("one", "two", "three")}.to raise_error(ArgumentError)
    end
  end

  describe "#some_field_missing?" do
    it "returns true if the given oauth params is incomplete" do
      expect(User.some_field_missing?(set_valid_omniauth)).to be false
    end

    it "returns false if the given oauth params is complete" do
      expect(User.some_field_missing?(set_invalid_omniauth)).to be true
    end

    it "throws an error if called without wrong number of arguments" do
      expect{User.some_field_missing?("one", "two")}.to raise_error(ArgumentError)
      expect{User.some_field_missing?}.to raise_error(ArgumentError)
    end
  end

end

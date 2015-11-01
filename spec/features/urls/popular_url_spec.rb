require 'rails_helper'

describe "Visiting the homepage" do
  Url.delete_all
  def generate_url(amount = 20,   views = nil)
    amount.times do
      views ||= rand(1..10)
      Url.create(original: Faker::Internet.url, views: views)
    end
    visit "/urls/new"
  end

  # it "displays nothing if db is empty" do
  #   visit "/urls/new"
  #   within "div.popular_urls" do
  #     within("h2") do
  #       expect(page).to_not have_content("Popular Urls")
  #     end
  #     # expect(("ul li").size).to eq(0)
  #   end
  # end

  describe "if db is not empty" do
    # it "displays popular urls" do
    #   generate_url(10)
    #   within "div .popular_urls" do
    #     within("h2") do
    #       expect(page).to have_content("Popular Urls")
    #     end
    #     expect(("ul li").size).to eq(10)
    #   end
    # end
  #
    it "displays the Url with the most view" do
      expect(Url.count).to eql(0)
      generate_url(20, 50)
      visit "/urls/new"
    end
  #
  #   it "displays maximum of 20 Url" do
  #
  #   end
  end
end

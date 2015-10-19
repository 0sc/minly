require 'rails_helper'

describe "Shortening Urls" do
  Url.delete_all

  def input_url_to_be_shortened(url = "http://kissanime.com/naruto_shippudden")
    visit "/urls/new"
    fill_in "Original", with: url
    click_button "Create Url"
  end

  it "displays 'shorten url message' on visit to homepage" do
      visit "/urls/new"
      expect(page).to have_content('New Url')
  end

  describe "If input is valid" do
    it "shows the shortened url on the page" do
      input_url_to_be_shortened

      expect(page).to have_content("http://kissanime.com/naruto_shippudden")
      expect(Url.count).to eq(1)
      # expect(page).to have_content("https://localhost.com::800")
    end
  end

  describe "If input is invalid" do
    it "displays an error when no title is entered" do
      input_url_to_be_shortened ""
      # within "h1" do
      #   expect(page).to have_content("Your input in invalid.")
      # end
    end

    # it "displays an error when an invalid url is entered" do
    #   expect(Url.count).to eq(0)
    # end

    it "does not store the input to the database" do
      input_url_to_be_shortened ""
      expect(Url.count).to eq(0)
    end

    it "does not show the input on the list of urls on the page" do
      input_url_to_be_shortened ""
      expect(page).to_not have_content("a very bad url input")
    end
  end

  describe "If the input long url already exists in the database" do
    it "does not store the input again in the database" do
      @url = Url.create(original: "http://google.com")
      input_url_to_be_shortened "http://google.com"
      expect(Url.count).to eq(1)
    end

    it "does not throw an error message" do
      @url = Url.create(original: "http://google.com")
      input_url_to_be_shortened "http://google.com"
      expect(page).to_not have_content("An error occurred with your input")
    end

    it "returns the already shortened url" do
      @url = Url.create(original: "http://google.com")
      input_url_to_be_shortened "http://google.com"
      expect(page).to have_content(@url.shortened)
    end
  end
end

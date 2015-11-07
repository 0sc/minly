require "rails_helper"

def fill_form (input = Faker::Internet.url)
  visit root_path

  within ".welcome" do
    fill_in('url[original]', with: input)
    click_button("Test it out")
  end
end

feature "Create regular minlys without vanity string" do
  it "has form for creating minlys" do
    visit root_path
    within ".welcome" do
      find("form")
    end
  end

  describe "using the form" do
    it "returns the created minly for valid input" do
      fill_form
      visit root_path
      within(".recent") do
        expect(page).to have_content Url.last.shortened
      end
    end

    it "does not create minly for empty input" do
      fill_form(nil)
      visit root_path
      within ".recent" do
        expect(page).not_to have_css ("ul")
      end
    end

    it "does not create multiple minly of same original url for regular users" do
      expect(Url.all.size).to eq 0
      fill_form ("http://google.com")
      url = Url.last
      expect(Url.all.size).to eq 1
      fill_form ("http://google.com")
      expect(Url.all.size).not_to eq 2
      visit root_path
      within(".recent") do
        expect(page).to have_content url.shortened
      end
    end
  end

  describe "created minly is added to Recent Minlys on reload" do
    it "tags the recent minly as the most recent" do
      fill_form
      visit root_path
      within(".recent") do
        expect(find("ul li:first-child")).to have_content Url.last.shortened
      end
    end
  end
end

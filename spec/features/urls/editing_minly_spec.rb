require "rails_helper"

def user_sign_in
  set_valid_omniauth
  visit root_path
  within ".navbar" do
    find("li.navbar-item")
    within "li.navbar-item" do
      page.click_link("Sign in")
      page.find("li:first-child a").click
    end
  end
end

def fill_form(input = Faker::Internet.url, string = Faker::Lorem.word + rand(1..10).to_s)
  within ".welcome" do
    fill_in('url[original]', with: input)
    fill_in('url[shortened]', with: string)
    click_button("Test it out")
  end
  visit dashboard_path
end

feature "Editing minly" do
  describe "If user has created minly" do
    before(:each) do
      user_sign_in
      fill_form("http://minly.herokuapp.com")
    end

    it "provides an edit form for uses to edit minly" do
      find("#edit_form")
      within("#edit_form") do
        expect(page.find("h4")).to have_content "Manage Minlys"
      end
    end

    it "shows details of the selected minly" do
      url = Url.first
      within(".url-listing") do
        expect(page).to have_content "My Minlys"
        find("div p").click
      end
      within(".statistics") do
        expect(page).to have_content "Details"
        within("#edit_form") do
          expect(page).to have_content url.original
          expect(page).to have_content url.shortened
          expect(page).to have_content url.views
          expect(page).to have_content "Status"
        end
      end
    end
  end

  describe "editing" do
    before(:each) do
      user_sign_in
      fill_form("http://minly.herokuapp.com")
    end

    it "allows users to change the target of a minly" do
      within('#edit_form') do
        fill_in("url[original]", with: "http://minly.com")
        click_button("save")
      end
      expect(Url.first.original).to eq "http://minly.com"
    end

    it "does not change target if new target is invalid url" do
      within('#edit_form') do
        fill_in("url[original]", with: "http://minly")
        click_button("save")
      end
      expect(Url.first.original).to_not eq "http://minly"
      expect(Url.first.original).to eq "http://minly.herokuapp.com"
    end

    it "allows users to deactivate a minly" do
      within('#edit_form') do
        uncheck("url[active]")
        click_button("save")
      end
      expect(Url.first.active).to be false
    end

    it "allows users to activate a minly" do
      Url.first.active = false
      within('#edit_form') do
        check("url[active]")
        click_button("save")
      end
      expect(Url.first.active).to be true
    end

    it "allows users to delete a minly" do
      expect(Url.all.size).to be 1
      within('#edit_form') do
        click_link("delete")
      end
      expect(Url.all.size).to be 0
      visit dashboard_path
      expect(page).to_not have_content "http://minly.herokuapp.com"
    end
  end

  describe "if user has no minly" do
    before(:each) do
      user_sign_in
    end

    it "doesn't provide edit form and usage statics for users without minlys" do
      expect(page).to_not have_content("Details")
      expect(page).to_not have_content("My Minlys")
      expect(page).to_not have_content("Manage Minlys")
    end

    it "display banner for user to create minly" do
      expect(page).to have_content("Try it out; shorten a url.")
    end
  end
end

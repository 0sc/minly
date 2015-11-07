require "rails_helper"

def find_authentication_button(&block)
  visit root_path
  within ".navbar" do
    find("li.navbar-item")
    within "li.navbar-item" do
      expect(page).to have_content("Sign in")
      yield if block_given?
    end
  end
end

feature "Authenticate User" do
  it "provides button for users to click to sign in" do
    find_authentication_button
  end

  describe "clicking the sign up button" do
    it "provides sign in options for facebook" do
      find_authentication_button do
        click_link("Sign in")
          find("li:first-child").click
          expect(page.find("li:first-child").text).to eq "Facebook"
      end
    end

    it "provides sign in options for twitter" do
      find_authentication_button do
        click_link("Sign in")
        find("li:nth-child(2)").click
        expect(page.find("li:nth-child(2)").text).to eq "Twitter"
      end
    end

    it "provides sign in options for google" do
      find_authentication_button do
        click_link("Sign in")
        find("li:last-child").click
        expect(page.find("li:last-child").text).to eq "Google"
      end
    end
  end

  describe "Valid oauth callback" do
    before(:each) do
      set_valid_omniauth
    end
    it "creates user if user doesn't exist" do
      find_authentication_button do
        page.click_link("Sign in")
        page.find("li:first-child a").click
        expect(User.all.size).to eq 1
        expect(current_path).to eq dashboard_path
      end
    end

    it "does not create user if user already exists" do
      find_authentication_button do
        click_link("Sign in")
        page.find("li:first-child a").click
        expect(User.all.size).to eq 1
        page.find("li:last-child a").click
      end
      page.reset!
      find_authentication_button do
        click_link("Sign in")
        page.find("li:first-child a").click
        expect(User.all.size).not_to eq 2
        expect(User.all.size).to eq 1
      end
    end
  end

  describe "Invalid oauth callback" do
    before(:each) do
      set_invalid_omniauth
      find_authentication_button do
        page.click_link("Sign in")
        page.find("li:first-child a").click
      end
    end
    it "does not create users" do
      expect(User.all.size).to eq 0
    end

    it "redirects to the index page" do
      expect(current_path).to eq root_path
    end

    it "shows an error message" do
      expect(page.find("#notification").text).to have_content "An error occured. Please try again."
    end
  end

  describe "user logout" do
    before(:each) do
      set_valid_omniauth
      find_authentication_button do
        page.click_link("Sign in")
        page.find("li:first-child a").click
      end
    end
    it "shows logout and dashboard buttons for logged in users" do
      expect(page.find("nav ul.navbar-list li:first").text).to have_content "Sign out"
      expect(page.find("nav ul.navbar-list li:last").text).to have_content "Dashboard"
    end

    it "logs users out of the app" do
      click_link("Sign out")
      expect(page.find("#notification").text).to have_content "Signed out"
    end
  end

  describe "does not show log out button for not signed users" do
    it "shows a login button instead" do
      set_invalid_omniauth
      find_authentication_button do
        expect(page).not_to have_content "Sign out"
      end
    end
  end
end

require "rails_helper"

def navigation(&block)
  set_valid_omniauth
  visit root_path
  within ".navbar" do
    find("li.navbar-item")
    within "li.navbar-item" do
      yield if block_given?
    end
  end
end

def sign_in
  click_link "Sign in"
  find("li:first-child a").click
end

feature "User Sign in" do
  it "allows users to sign in" do
    navigation do
      expect(page).to have_content("Sign in")
      sign_in
    end
    expect(page).to have_content("Hello")
  end

  it "allows users to sign out" do
    navigation do
      sign_in
    end
    click_link("Sign out")
    expect(page.find("#notification").text).to have_content "Signed out"
  end

  it "allows users to navigate to dashboard" do
    navigation do
      sign_in
    end
    visit root_path
    click_link("Dashboard")
    expect(page).to have_content("Hello")
  end
end

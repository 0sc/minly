require "rails_helper"

def user_sign_in_here
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
end

feature "Create customized minly" do
  it "provides logged in users form field to create customized minlys" do
    user_sign_in_here
    expect(current_path).to eq dashboard_path
    within ".welcome" do
      find("form")
    end
  end

  describe "customizing minly" do
    before(:each) do
      user_sign_in_here
    end

    it "allows users to create minly that match the provided vanity string" do
      fill_form("http://bing.com", "bing")
      expect(Url.all.size).to eq 1
      visit dashboard_path
      within ".url-listing" do
        expect(page).to have_content "/b"
      end
    end

    it "allows users to create minly without a vanity string" do
      fill_form("http://bing.com")
      expect(Url.all.size).to eq 1
      visit dashboard_path
      within ".url-listing" do
        expect(page).to have_content Url.last.shortened
      end
    end

    it "allows users to create multiple minlys for the same original url" do
      num = Faker::Number.between(1, 10)
      num.times { fill_form("http://bing.com") }

      expect(Url.all.size).to eq num

      visit dashboard_path
      within ".url-listing div" do
        Url.all.each do |url|
          expect(page).to have_content url.shortened
        end
      end
    end

    it "does not allow users reuse minly" do
      num = Faker::Number.between(1, 10)
      num.times { fill_form("http://bing.com", "bing") }

      expect(Url.all.size).to eq 1

    end

    it "does not save if the given minly is not alphanumeric" do
      fill_form("http://bing.com", "/(&^^%%$)")
      fill_form("http://bing.com", " sdf897&^^%sdfsf")
      fill_form("http://bing.com", "jsd sfd")

      expect(Url.all.size).to eq 0
    end

    it "does not save if blank form is submitted" do
      fill_form("", "")
      expect(Url.all.size).to eq 0
    end
  end

end

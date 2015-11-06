require "rails_helper"

def create_url_and_visit_page
  10.times { create(:url) }
  visit "/"
end

feature "Popular url" do
  it "displays popular urls on visit to the site" do
    visit "/"
    expect(page).to have_content "Popular Minlys"
  end

  describe "arrangement of popular urls" do
    it "displays urls arranged according to the number of views" do
      popular = create(:url, views: 100000)
      create_url_and_visit_page
      within ".popular" do
        expect(("ul li").size).to eq 5
        expect(page).to have_content popular.shortened
      end
    end

    it "displays only the top 5 urls" do
      last = create(:url, views: 0)
      popular = create(:url, views: 100000)
      create_url_and_visit_page
      within ".popular" do
        expect(("ul li").size).to eq 5
        expect(page).not_to have_content last.shortened
        expect(page).to have_content popular.shortened
        expect(Url.all.size).to be > 5
      end
    end

    it "displays nothing if no url is exists" do
      visit "/"
      expect(page).to have_content "Popular Minlys"
      within ".popular" do
        expect(page).not_to have_content "ul"
      end
    end

    it "redirects to the original url when clicked" do
      popular = create(:url, views: 100000)
      create_url_and_visit_page
      within ".popular" do
        click_link (host_url + popular.shortened)
        expect(response).to redirect_to popular.original
      end
      visit "/"
      within ".popular" do
        expect(page).to have_content(100001)
      end
    end
  end

end

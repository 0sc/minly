require "rails_helper"

def create_url_and_visit_page(num=5)
  num.times { create(:url) }
  visit root_path
end

feature "Popular url" do
  it "displays popular urls on visit to the site" do
    visit root_path
    expect(page).to have_content "Popular Minlys"
  end

  describe "arrangement of popular urls" do
    it "displays urls arranged according to the number of views" do
      popular = create(:url, views: 100000)
      create_url_and_visit_page 10
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
        expect(page).not_to have_css("ul")
      end
    end
  end

end

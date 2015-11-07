require "rails_helper"

def create_url_and_visit_page(num=5)
  num.times { create(:url) }
  visit "/"
end

feature "Recent url" do
  it "displays recent urls on visit to the site" do
    visit "/"
    expect(page).to have_content "Recent Minlys"
  end

  describe "arrangement of recent urls" do
    it "displays urls arranged according to the time they where created" do
      create_url_and_visit_page
      recent = create(:url)
      create_url_and_visit_page(0)

      within ".recent" do
        expect(("ul li").size).to eq 5
        expect(page.find("ul li:first")).to have_content recent.shortened
      end
    end

    it "displays only the top 5 urls" do
      first = create(:url)
      create_url_and_visit_page
      recent = create(:url)

      create_url_and_visit_page(0)
      within ".recent" do
        expect(("ul li").size).to eq 5
        expect(page).not_to have_content first.shortened
        expect(page).to have_content recent.shortened
        expect(Url.all.size).to be > 5
      end
    end

    it "displays nothing if no url is exists" do
      visit "/"
      expect(page).to have_content "Recent Minlys"
      within ".recent" do
        expect(page).not_to have_css("ul")
      end
    end
  end

end

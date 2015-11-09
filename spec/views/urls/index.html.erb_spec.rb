require 'rails_helper'

RSpec.describe "urls/index", type: :view do
  before(:each) do
    create(:url, shortened: "minly")
    assign(:urls, build(:url))
  end

  it "renders a list of urls" do
    render
    assert_select ".popular > ul", :text => "http://test.host/minly".to_s, :count => 1
    assert_select ".recent > ul", :text => "http://test.host/minly".to_s, :count => 1
  end

end

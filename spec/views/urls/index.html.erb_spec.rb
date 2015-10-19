require 'rails_helper'

RSpec.describe "urls/index", type: :view do
  before(:each) do
    assign(:urls, [
      Url.create!(
        :original => "Original",
        :redirect => "Redirect",
        :active => "Active"
      ),
      Url.create!(
        :original => "Original",
        :redirect => "Redirect",
        :active => "Active"
      )
    ])
  end

  it "renders a list of urls" do
    render
    assert_select "tr>td", :text => "Original".to_s, :count => 2
    assert_select "tr>td", :text => "Redirect".to_s, :count => 2
    assert_select "tr>td", :text => "Active".to_s, :count => 2
  end
end

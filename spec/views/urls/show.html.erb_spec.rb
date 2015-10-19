require 'rails_helper'

RSpec.describe "urls/show", type: :view do
  before(:each) do
    @url = assign(:url, Url.create!(
      :original => "Original",
      :redirect => "Redirect",
      :active => "Active"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Original/)
    expect(rendered).to match(/Redirect/)
    expect(rendered).to match(/Active/)
  end
end

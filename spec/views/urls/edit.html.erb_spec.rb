# require 'rails_helper'
#
# RSpec.describe "urls/edit", type: :view do
#   before(:each) do
#     @url = assign(:url, Url.create!(
#       :original => "MyString",
#       :redirect => "MyString",
#       :active => "MyString"
#     ))
#   end
#
#   it "renders the edit url form" do
#     render
#
#     assert_select "form[action=?][method=?]", url_path(@url), "post" do
#
#       assert_select "input#url_original[name=?]", "url[original]"
#
#       assert_select "input#url_redirect[name=?]", "url[redirect]"
#
#       assert_select "input#url_active[name=?]", "url[active]"
#     end
#   end
# end

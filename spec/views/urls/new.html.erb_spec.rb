# require 'rails_helper'
#
# RSpec.describe "urls/new", type: :view do
#   before(:each) do
#     assign(:url, Url.new(
#       :original => "MyString",
#       :redirect => "MyString",
#       :active => "MyString"
#     ))
#   end
#
#   it "renders new url form" do
#     render
#
#     assert_select "form[action=?][method=?]", urls_path, "post" do
#
#       assert_select "input#url_original[name=?]", "url[original]"
#
#       assert_select "input#url_redirect[name=?]", "url[redirect]"
#
#       assert_select "input#url_active[name=?]", "url[active]"
#     end
#   end
# end

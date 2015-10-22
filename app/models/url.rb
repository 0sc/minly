class Url < ActiveRecord::Base
  validates_presence_of :original, :message => "Please enter url to be shortened." 
  validates :original, uniqueness: true
  # validates :original, format: { with: /\w_@\w_.\w*/ }, message: ""

  # private
  def save_shortened (shortened_url)
    update_attribute(:shortened, shortened_url)
  end
end

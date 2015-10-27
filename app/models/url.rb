class Url < ActiveRecord::Base
  validates_presence_of :original, :message => "Please enter url to be shortened."
  validates :original, url: true
  # validates :original, format: { with: /\w_@\w_.\w*/ }, message: ""

  # private
  def save_shortened (shortened_url)
    update(shortened: shortened_url)
  end
end

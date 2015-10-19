class Url < ActiveRecord::Base
  validates :original, presence: true, uniqueness: true
  # validates :original, format: { with: /\w_@\w_.\w*/ }, message: ""

  # private
  def save_shortened (shortened_url)
    update_attribute(:shortened, shortened_url)
  end
end

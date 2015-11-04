class Url < ActiveRecord::Base
  validates_presence_of :original, :message => "is not provided"
  validates :original, url: true
  validates :shortened, allow_nil: true, format: { with: /[A-Za-z0-9]/, message: "should be only alphanumeric characters."}

  # private
  def save_shortened (shortened_url)
    update(shortened: shortened_url)
  end

  def save_this_visit
    update_attribute(:views, views + 1)
  end

  def self.popular(num = 5)
    order(views: :desc).limit(num)
  end

  def self.recent(num = 5)
    limit(num).order(created_at: :desc)
  end

  def self.get_url(arg, col=:id)
    find_by(col => arg)
  end

  def self.init_with(hash)
    find_or_initialize_by(hash)
  end

end

class Url < ActiveRecord::Base
  validates_presence_of :original, :message => "is not provided"
  validates :original, url: true
  validates :shortened, allow_nil: true, format: { with: /\A[A-Za-z0-9]+\z/, message: "should be only alphanumeric characters."}, uniqueness: true

  after_save :save_shortened

  # private

  def create_shortened_url(url_id)
    url_id.to_s(32).reverse
  end

  def save_shortened
    update(shortened: create_shortened_url(id)) if shortened.nil?
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

class Url < ActiveRecord::Base
  # visitable
  has_many :ahoy_events, class_name: "Ahoy::Event"
  has_many :visits, through: :ahoy_events

  validates_presence_of :original, :message => "is not provided"
  validates :original, url: true
  validates :shortened, allow_nil: true, format: { with: /[A-Za-z0-9]/, message: "should be only alphanumeric characters."}

  # private
  def save_shortened (shortened_url)
    update(shortened: shortened_url)
  end

  def note_this_visit
    update_attribute(:views, views + 1)
  end

  def self.popular(num = 20)
    order(views: :desc).limit(num)
  end

  def self.recent(num = 20)
    limit(num).order(created_at: :desc)
  end

  # def self.original_url_already_exists(url)
  #   find_by_original(url)
  # end
  #
  # def self.vanity_url_already_exists(url)
  #   find_by_shortened(url)
  end
end

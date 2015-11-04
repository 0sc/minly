class UserDecorator < Draper::Decorator
  attr_reader :my_urls

  delegate_all

  def get_user_token
    token
  end

  def has_urls?
    @my_urls = get_urls
    my_urls.size
  end

  def last_url
    my_urls.last
  end
  def first_url
    my_urls.first
  end

end

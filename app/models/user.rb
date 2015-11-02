class User < ActiveRecord::Base
  has_many :urls

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name  = auth.info.name
      user.oauth_token = auth.credentials.token
      user.token = SecureRandom.urlsafe_base64(32)
      user.save!
    end
  end

  def get_urls
    urls.order("id desc")
  end

  def search_url_for(url, col = :shortened)
    urls.where(col => url)
  end

  def self.get_user(arg, col = :id)
    find_by(col => arg)
  end

end

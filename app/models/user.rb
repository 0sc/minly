class User < ActiveRecord::Base
  validates :provider, :uid, :oauth_token, :presence => true

  has_many :urls

  def self.from_omniauth(auth)
    if some_field_missing?(auth)
      # flash[:error] = "Invalid auth response."
      return false
    end

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

  def self.some_field_missing?(auth)
    fields = %w{provider uid info credentials}
    val = false

    fields.each { |f| val = true unless auth.respond_to? f }
    return true if val
    return true unless auth.info.respond_to? "name"
    return true unless auth.credentials.respond_to? "token"
    false
  end

end

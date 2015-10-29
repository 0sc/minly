class User < ActiveRecord::Base
  has_many :urls

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      # user.profile_url = auth.info.image
      user.name  = auth.info.name
      user.oauth_token = auth.credentials.token
      user.token = SecureRandom.urlsafe_base64(32)
      user.save!
    end
  end
end

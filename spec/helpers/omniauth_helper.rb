def set_valid_omniauth
  OmniAuth.config.add_mock(:facebook, mock_fb_oauth_response)
end

def set_invalid_omniauth
  OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
end

def mock_fb_oauth_response
  OmniAuth::AuthHash.new(
    {
        :provider => "facebook",
        :uid => "1234567",
        :info => {
          :email => "user@minly.com",
          :name => "user mock",
          :first_name => "User",
          :last_name => "Mock",
          :image => "http://graph.facebook.com/1234567/picture?type=square",
          :urls => { :Facebook => "http://www.facebook.com/umock" },
          :location => "Palo Alto, California",
          :verified => true
        },
        :credentials => {
          :token => "ABCDEF...",
          :expires_at => 1321747205,
          :expires => true
        },
        :extra => {
          :raw_info => {
            :id => "1234567",
            :name => "User mocks",
            :first_name => "User",
            :last_name => "Mocks",
            :link => "http://www.facebook.com/umock",
            :username => "umocks",
            :location => { :id => "123456789", :name => "Palo Alto, California" },
            :gender => "male",
            :email => "user@minly.com",
            :timezone => -8,
            :locale => "en_US",
            :verified => true,
            :updated_time => "2011-11-11T06:21:03+0000"
          }
        }
  }
)
end

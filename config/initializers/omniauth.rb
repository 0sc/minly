OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = SessionsController.action(:create)
  provider :twitter, ENV["twitter_api_key"], ENV["twitter_api_secret"]
  provider :facebook, ENV['facebook_app_id'], ENV['facebook_app_secret'],
           :scope => 'email', :info_fields => 'name, email'
  provider :google_oauth2, ENV["google_client_id"], ENV["google_client_secret"]
end

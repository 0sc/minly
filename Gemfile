source 'https://rubygems.org'

ruby "2.4.2"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.7'

gem "skeleton-rails"
gem 'uglifier', '>= 1.3.0'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'omniauth-oauth2', '~> 1.3.1'
gem "omniauth-twitter"
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'valid_url'
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
gem 'figaro'
gem 'draper'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  gem 'byebug', '~> 6.0.2'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'faker'
  gem 'pry-nav'
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter', require: nil
  gem 'simplecov'
end

group :production do
  gem 'pg'
  gem 'puma'
  gem 'rails_12factor'
end

class UsersController < ApplicationController
  before_action :authenticate_user

  def index
    @urls = current_user.get_recent_urls
  end
end

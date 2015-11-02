class UsersController < ApplicationController
  before_action :authenticate_user

  def index
    @urls = current_user.get_urls
  end
end

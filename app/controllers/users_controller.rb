class UsersController < ApplicationController
  before_action :authenticate_user

  def index
    @user_decorator = current_user
    # @urls = current_user.get_urls.decorate
  end
end

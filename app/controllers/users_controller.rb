class UsersController < ApplicationController
  before_action :authenticate_user

  def index
    @user_decorator = current_user.decorate
  end
end

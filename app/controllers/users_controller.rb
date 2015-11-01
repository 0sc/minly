class UsersController < ApplicationController
  before_action :check_login

  def index
    @urls = current_user.urls.order("id desc")
  end


  private

  def check_login
    if !current_user
      redirect_to(root_path, error: 'You have to log in except you are Ore')
    end
  end
end

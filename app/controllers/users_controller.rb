class UsersController < ApplicationController
  def index
    @url = Url.find_by(user_id: current_user)
  end
end

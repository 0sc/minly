class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env['omniauth.auth'])

    if user && user.id
      session[:user_id] = user.id
      flash[:notice] = "Signed in successfully!"
      redirect_to dashboard_path
    else
      flash[:notice] = "An error occured. Please try again."
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out"
    redirect_to root_url
  end
end

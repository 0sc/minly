require "serializer_methods"
class ApplicationController < ActionController::Base

  include SerializerMethods
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  private

  def current_user
    @current_user ||= User.get_user(session[:user_id]) if session[:user_id]
    authenticate_user_with_token unless @current_user
    @current_user
  end
  helper_method :current_user

  def authenticate_user
    unless current_user
      flash[:error] = "You need to log in"
      process_action_callback(@url, :error, "Request not completed. You need to log in.", root_path)
    end
  end

  def authenticate_user_with_token
    @current_user = User.get_user(params[:user_token], :token) if params[:user_token]
  end
end

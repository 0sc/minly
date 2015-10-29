class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_request_session

  def shorten
    # some method to shorten should give us route
    # if route, render json'd route
    # else, render json: {error: "wahala don dey"}
  end

  private

  def destroy_request_session
    request.session_options[:skip] = true
  end


end

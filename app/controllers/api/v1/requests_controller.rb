class Api::V1::RequestsController < Api::V1::BaseController
  include RequestsHelper
  require 'cgi'
  respond_to :json, :xml

  def create
    original_url = CGI.unescape(params[:original])
    vanity_string = params[:short_url]
    user_token = params[:user_token]

    @current_user = get_user_object(user_token)

    process_url(original_url, vanity_string)
    respond_with flash.first
  end

  def show
    url = params[:short_url]
    user_token = params[:user_token]
    target_action = params[:target]
    respond_with get_request_managers(target_action, url, user_token)
    # respond_with popular_urls
  end

  def update
    url = params[:short_url]
    user_token = params[:user_token]
    target_action = params[:target]
    data = params[:data]

    respond_with get_update_managers(target_action, url, user_token, data)
  end

  def destroy
    url = params[:short_url]
    user_token = params[:user_token]

    respond_with delete_url(url, user_token)
  end

  private

  def get_request_managers(action, shortened_url, user_token)
    responsible = {
        "popular" => :popular_urls,
        "recent" =>  :recent_urls,
        "expand" =>  [:expand_url, shortened_url],
        "authorize" => [:verify_user, user_token],
        "my_urls" => [:user_urls, user_token],
        "statistics" => [:url_statistics, shortened_url]
    }

    action = responsible[action]
    (action.is_a?Array) ? send(action.first, action.last) : send(action)
  end

  def get_update_managers(action, shortened_url, user_token, data)
    responsible = {
        "status" => :set_url_status,
        "origin" => :set_url_origin
    }

    send(responsible[action], shortened_url, user_token, data)
  end

end

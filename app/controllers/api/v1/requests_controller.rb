class Api::V1::RequestsController < Api::V1::BaseController
  include RequestsHelper
  respond_to :json, :xml

  def create
  end

  def show
    url = params[:short_url]
    user_token = params[:user_id]
    target_action = params[:target]
    # require "pry"; binding.pry
    respond_with get_request_managers(target_action, url, user_token)
    # respond_with popular_urls
  end

  private

  def get_request_managers(action, shortened_url, user_token)
    responsible = {
        "popular" => :popular_urls,
        "recent" =>  :recent_urls,
        "expand" =>  [:expand_url, shortened_url],
        "history" => [:user_urls, user_token],
        "statistics" => [:url_statistics, shortened_url]
    }

    action = responsible[action]
    (action.is_a?Array) ? send(action.first, action.last) : send(action)
  end
end

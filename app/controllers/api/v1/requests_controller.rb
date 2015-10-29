class Api::V1::RequestsController < Api::V1::BaseController
  include RequestsHelper
  respond_to :json, :xml

  def create
  end

  def show
    url = params[:short_url]
    user_id = params[:user_id]
    target_action = params[:target]
    # require "pry"; binding.pry
    respond_with get_request_managers(target_action, url, user_id)
    # respond_with popular_urls
  end

  private

  def get_request_managers(action, shortened_url, user_id)
    responsible = {
        "popular" =>  send(:popular_urls),
        "recent" =>  send(:recent_urls),
        "expand" =>  send(:expand_url, shortened_url),
        "history" =>  send(:user_urls, user_id),
        "statistics" =>  send(:url_statistics, shortened_url)
    }

    responsible[action]
  end
end

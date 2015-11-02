class Api::V1::RequestsController < Api::V1::BaseController
  include RequestsHelper

  def show
    url = params[:short_url]
    target_action = params[:target]
    respond_with get_request_managers(target_action, url)
    # respond_with popular_urls
  end

  private

  def get_request_managers(action, shortened_url)
    responsible = {
        "popular" => :popular_urls,
        "recent" =>  :recent_urls,
        "expand" =>  [:expand_url, shortened_url],
    }

    action = responsible[action]
    (action.is_a?Array) ? send(action.first, action.last) : send(action)
  end
end

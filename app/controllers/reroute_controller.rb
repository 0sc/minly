class UrlsController < ApplicationController
  include RerouteHelper

  def index
    target = reroute_params[:path]
    #ARM breaks if null query
    target = Url.get_url(target, :shortened) unless target.empty?

    if target && !target.empty?
      manage_redirection(target)
    else
      #Maybe show error message!??
      redirect_to root_path
    end
  end

  private

  def reroute_params
    params.permit(:path)
  end

end

class RerouteController < ApplicationController
  include RerouteManager

  def index
    target = reroute_params[:path]
    #ARM breaks if null query
    target = Url.get_url(target, :shortened) if target

    if target
      manage_redirection(target)
    else
      manage_missing_target(target)
    end
  end

  private

  def reroute_params
    params.permit(:path)
  end

end

class RerouteController < ApplicationController
  include RerouteManager

  def index
    target = reroute_params[:path]
    #ARM breaks if null query
    target = Url.get_url(target, :shortened) if target

    if target
      manage_redirection(target)
    else
      #Maybe show error message!??
      manage_inactive_target
    end
  end

  private

  def reroute_params
    params.permit(:path)
  end

end

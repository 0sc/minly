class RerouteController < ApplicationController
  include RerouteHelper

  def index
    target = reroute_params[:path]
    #ARM breaks if null query
    target = Url.get_url(target, :shortened) if target

    if target
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

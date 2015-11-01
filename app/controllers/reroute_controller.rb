class UrlsController < ApplicationController
  include RerouteHelper

  def index
    incoming = reroute_params[:path]
    if !incoming.empty?
      target = Url.find_by_shortened(incoming)

      if target
        #Do all the statistics thingy at this point
        if target.active
          ahoy.track "Visit #{incoming}", url_id: target.id
          Ahoy::Event.where(name: "Visit #{incoming}").update_all(url_id: target.id)
          ahoy.track_visit
          target.note_this_visit
          redirect_to (target.original)
          return
        end
        status = set_inactive_url_notification(incoming)
      end
      status ||= set_not_found_notification(incoming)
      flash[:error] = 'Oops! An error occured.' + "<br />" + status
    end

    set_view_data
    render "new"
  end

end

class UrlsController < ApplicationController
  include RequestsHelper

  before_action :authenticate_user, :only => [:update, :destroy]
  before_action :set_url, only: [:update, :destroy]

  # GET /urls
  # GET /urls.json
  def index
    redirect_to root_path
  end

  def reroute
    incoming = reroute_params[:path]
    if !incoming.empty?
      target = Url.find_by(shortened: incoming)

      if target
        #Do all the statistics thingy at this point
        if target.active
          ahoy.track "Visit #{incoming}", url_id: target.id
          Ahoy::Event.where(name: "Visit #{incoming}").update_all(url_id: target.id)
          ahoy.track_visit
          target.update_attribute(:views, target.views + 1)
          redirect_to (target.original)
          # redirect_to(dashboard_url)
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

  # GET /urls/new
  def new
    set_view_data
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = process_url(url_params[:original], url_params[:shortened])
    return_path = current_user ?
    dashboard_url : root_path
    process_action_callback(@url, "", "", return_path)
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    if @url.update(update_params)
      process_action_callback(:success, @url, "Url was updated successfully.")
    else
      process_action_callback(:error, @url, "Invalid params provided. Request could not be completed.")
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    if @url
      @url.destroy
      process_action_callback(:success, @url, "Url was deleted successfully.")
    else
      process_action_callback(:error, @url, "Invalid params provided. Request could not be completed.")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find_by(:id => params[:id])
      @url ||= Url.find_by_shortened(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:original, :shortened)
    end

    def update_params
      params.require(:url).permit(:original, :active)
    end

    def reroute_params
      params.permit(:path)
    end

    def set_view_data
      @urls = Url.recent
      @url  = Url.new
      @popular_urls = Url.popular
      @header = "main_header"
    end
end

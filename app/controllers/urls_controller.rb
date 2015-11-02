class UrlsController < ApplicationController
  include UrlProcessor

  before_action :authenticate_user, :only => [:update, :destroy, :show]
  before_action :set_url, only: [:update, :destroy]

  # GET /urls
  # GET /urls.json
  def index
  end

  def show
    @url = Url.get_url(params[:id])
    if @url
      process_action_callback(@url, :success, "Url was retrieved successfully.")
    else
      process_action_callback(@url, :error, "Invalid params provided. Request could not be completed.")
    end
  end

  # POST /urls
  # POST /urls.json
  def create
    params = url_params
    @url = process_url(params[:original], params[:shortened])
    return_path = current_user ?
    dashboard_url : root_path
    process_action_callback(@url, "", "", return_path)
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    if @url.update(update_params)
      process_action_callback(@url, :success, "Url was updated successfully.")
    else
      process_action_callback(@url, :error, "Invalid params provided. Request could not be completed.")
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
      @url = Url.get_url(params[:id])
      @url ||= Url.get_url(params[:id], :shortened)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:original, :shortened)
    end

    def update_params
      params.require(:url).permit(:original, :active)
    end
end

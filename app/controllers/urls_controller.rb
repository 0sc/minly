class UrlsController < ApplicationController
  include UrlsHelper

  before_action :set_url, only: [:edit, :update, :destroy]

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

  # GET /urls/1/edit
  def edit
  end

  # POST /urls
  # POST /urls.json
  def create
    respond_to do |format|
      original = sanitize_url(url_params[:original])
      vanity_string   = url_params[:shortened] if current_user

      @url = current_user ? shorten_url_for_users(original, vanity_string) : shorten_url_for_default(original)

      if @url && @url.new_record?
        manage_save
      else
        flash[:notice] = "Record already exists" if @url
      end

        # format.html { redirect_to root_path, notice: 'Url was successfully created.' }
        # format.json { render :show, status: :created, location: @url }
      # else
      #   format.html { redirect_to root_path }

        if current_user
          redirect_to dashboard_url
          return
        end

        set_view_data

        format.html { render :new }
      #   # format.json { render json: @url.errors, status: :unprocessable_entity }
      # end
    end
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    respond_to do |format|
      if @url.update(edit_params)
        flash[:success] = 'Url was successfully updated.'
        # format.json { render :show, status: :ok, location: @url }
      else
        # format.html { render :edit }
        # format.json { render json: @url.errors, status: :unprocessable_entity }
      end
      format.html { redirect_to dashboard_url }
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:original, :shortened)
    end

    def edit_params
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

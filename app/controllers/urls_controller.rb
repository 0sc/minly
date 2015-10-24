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
          target.update_attribute(:views, target.views + 1)
          redirect_to (target.original)
          return
        end
        status = set_inactive_url_notification(incoming)
      end
      status ||= set_not_found_notification(incoming)
      @notification = ['Oops! An error occured.']
      @notification << status
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
      @url = Url.find_or_initialize_by(original: sanitize_url(url_params[:original]))
      if @url.save
        @url.save_shortened(create_shortened_url(@url.id)) if @url.shortened.nil?
        flash[:success] = "Url was shortened successfully."
      else
        @notice = @url.errors[:original]
      end

        # format.html { redirect_to root_path, notice: 'Url was successfully created.' }
        # format.json { render :show, status: :created, location: @url }
      # else
      #   format.html { redirect_to root_path }
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
      if @url.update(url_params)
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
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
      params.require(:url).permit(:original)
    end

    def reroute_params
      params.permit(:path)
    end

    def set_view_data
      @urls = Url.limit(20).order(created_at: :desc)
      @url  = Url.new
      @popular_urls = Url.order(views: :desc).limit(20)
      @header = "main_header"
    end
end

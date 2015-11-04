module SerializerMethods
  def process_action_callback(url, status, message, return_path = dashboard_url)
    flash[status] = message if status
    respond_to do |format|
      format.html { redirect_to return_path}
      format.json { render json: {:status => status, :status_info => flash[status], payload: url} }
      format.js {render :layout => false}
    end
  end

  def add_to_flash_message(hash)
    flash.merge(hash)
  end
end

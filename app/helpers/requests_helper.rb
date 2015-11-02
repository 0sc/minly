module RequestsHelper
  include UrlsHelper
  def expand_url(shortened)
    return [invalid_url_error] unless shortened
    request_status([Url.get_url(shortened, :shortened).as_json])
  end

  def popular_urls
    request_status(Url.popular)
  end

  def recent_urls
    request_status(Url.recent)
  end

  def process_action_callback(url, status, message, return_path = dashboard_url)
    flash[status] = message if status
    respond_to do |format|
      format.html { redirect_to return_path}
      format.json { render json: {:status => status, :status_info => flash[status], payload: url} }
      format.js {render :layout => false}
    end
  end

  def set_status(status, info)
    {
      status: status,
      status_info: info
    }
  end

  def request_status(result, error_info="", success_info="")
    if result && !result.first.nil?
      stat = success_info.empty? ? success_status : success_status(success_info)
    else
      stat = error_info.empty? ? error_status : error_status(error_info)
      result = []
    end
    result << stat
  end

  def success_status (info = "Request was processed successfully.")
    set_status("success", info)
  end

  def error_status(info = "The requested information could not be found.")
    set_status("error", info)
  end

  def invalid_url_error
    error_status("Invalid url provided.")
  end

  def get_user(token)
    User.get_user(user_token, :token)
  end

end

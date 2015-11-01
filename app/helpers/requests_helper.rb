module RequestsHelper
  include UrlsHelper
  def expand_url(shortened)
    return [invalid_url_error] unless shortened
    request_status([Url.find_by_shortened(shortened).as_json])
  end

  def popular_urls
    request_status(Url.popular)
  end

  def recent_urls
    request_status(Url.recent)
  end

  def user_urls(user_token)
    return [not_user_error] unless user_token

    user = get_user_object(user_token)
    return [not_user_error] unless user

    request_status(user.urls.order("id desc"))
  end

  def url_statistics(url)
    return [invalid_url_error] unless url
    request_status([])
  end

  def set_url_status(url, user_token, status)
    return [invalid_url_error] unless url
    return [not_user_error] unless get_user_object(user_token, url)

    url = Url.find_by_shortened(url)
    return [error_status("Shortened url not found")] unless url
    url.active = status
    url.save
    request_status([url.as_json], "Request could not be processed successfully.")
  end

  def set_url_origin(url, user_token,origin)
    # return [invalid_url_error] unless url
    # return [not_user_error] unless get_user_object(user_token, url)
    #
    # url = Url.find_by_shortened(url)
    # return [error_status("Shortened url not found")] unless url
    #
    # url.origin = "http://"+origin if !origin.match(/\A(http|https):\/\//)
    # url.save
    # request_status([url.as_json], "Request could not be processed successfully.")
    [error_status("This feature is current unavailable")]
  end

  def delete_url(url, user_token)
    return [invalid_url_error] unless url
    return [not_user_error] unless get_user_object(user_token, url)

    url = Url.find_by_shortened(url)
    return [error_status("Shortened url not found")] unless url
    request_status([url.destroy])
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

  def success_status (info = "Request was processed successfully.")
    set_status("success", info)
  end

  def error_status(info = "The requested information could not be found.")
    set_status("error", info)
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

  def not_user_error
    error_status("You don't have permission to make authorize the action.")
  end

  def invalid_url_error
    error_status("Invalid url provided.")
  end

  def get_user_object(token, url=nil)
    user = User.find_by_token(token)
    user = user.urls.where(shortened: "url") if url
    user
  end

end

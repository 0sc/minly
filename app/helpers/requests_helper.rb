module RequestsHelper
  def expand_url(shortened)
    return request_status(nil, "Invalid url provided") unless shortened
    request_status([Url.find_by_shortened(shortened).as_json])
  end

  def popular_urls
    request_status(Url.popular)
  end

  def recent_urls
    request_status(Url.recent)
  end

  def verify_user(token)
    return request_status(nil, "Invalid user token") unless token
    request_status([User.find_by_token(token).as_json], "User token does not exist.")
  end

  def user_urls(user_id)
    return request_status(nil,"Invalid login parameters. Your request require a valid user token.") unless user_id
    request_status([User.find(user_id).urls.order("id desc")])
  end

  def url_statistics(url)
    return request_status(nil,"error no url provided") unless url
    request_status([])
  end

  def set_url_active(url, user_id)
    return request_status(nil, "Invalid request parameters; url and/or user_token") unless url && user_id
  end

  def delete_url
  end

  def set_url_origin(url, user_id)
    return request_status(nil, "Invalid request parameters; url and/or user_token") unless url && user_id
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
    if result
      stat = success_info.empty? ? success_status : success_status(success_info)
    else
      stat = error_info.empty? ? error_status : error_status(error_info)
      result = []
    end
    result << stat
  end

end

module UrlProcessor
  def process_action_callback(url, status, message, return_path = dashboard_url)
    flash[status] = message if status
    respond_to do |format|
      format.html { redirect_to return_path}
      format.json { render json: {:status => status, :status_info => flash[status], payload: url} }
      format.js {render :layout => false}
    end
  end

  def process_url(original, vanity_string)
    original = sanitize_url(original)
    url = shorten_url(original, vanity_string)
    if url && url.new_record?
      url = manage_save(url)
    else
      flash[:notice] = "Record already exists" if url
    end
    url
  end

  def shorten_url(original, vanity_string)
    if current_user
      return shorten_url_for_users(original, vanity_string)
    else
      return shorten_url_for_default(original)
    end
  end

  def shorten_url_for_users(original, vanity_string)
    if vanity_string
      url = Url.init_with(shortened: vanity_string)
      url.original ||= original
    else
      url = shorten_url_for_default(original)
    end
    url.user_id ||= current_user.id
    url
  end

  def shorten_url_for_default(original)
    Url.init_with(original: original)
  end

  def sanitize_url(url)
    return if url.nil? || url.empty?
    url = "http://"+url if !url.match(/\A(http|https):\/\//) #add url sanitizer
    url
  end

  def manage_save(url)
    if url.save
      url.save_shortened(create_shortened_url(url.id)) if url.shortened.nil?
      flash[:success] = "Url was shortened successfully."
    else
      flash[:error] = format_error_msg(url)
    end
    url
  end

  def create_shortened_url (url_id)
      url_id.to_s(32).reverse
  end

  def format_error_msg(url)
    url.errors.full_messages.join(". ").gsub("Original", "Url input").gsub("Shortened", "Custom string")
  end

end

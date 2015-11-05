class UrlProcessor
  attr_reader :user, :notification
  def initialize(current_user)
    @user = current_user
    @notification = Hash.new
  end

  def process_url(original, vanity_string)
    original = sanitize_url(original)
    url = shorten_url(original, vanity_string)
    if url && url.new_record?
      url = manage_save(url)
    else
      add_notification_message(:success, "Minly created successfully.") if url
    end
    return url, notification
  end

  def shorten_url(original, vanity_string)
    if user
      return shorten_url_for_users(original, vanity_string)
    else
      return shorten_url_for_default(original)
    end
  end

  def shorten_url_for_users(original, vanity_string)

    if vanity_string && !vanity_string.empty?
      url = Url.init_with(shortened: vanity_string)
      url.original ||= original
    else
      url = shorten_url_for_default(original)
    end
    url.user_id ||= user.id
    url
  end

  def shorten_url_for_default(original)
    Url.init_with(original: original)
    # Url.new(original: original)
  end

  def sanitize_url(url)
    return if url.nil? || url.empty?
    url = "http://"+url if !url.match(/\A(http|https):\/\//) #add url sanitizer
    url
  end

  def manage_save(url)
    if url.save
      add_notification_message(:success, "Url was shortened successfully.")
    else
      add_notification_message(:error, format_error_msg(url))
    end
    url
  end

  def format_error_msg(url)
    url.errors.full_messages.join(". ").gsub("Original", "Url input").gsub("Shortened", "Custom string")
  end

  def add_notification_message(tag, msg)
    @notification[tag] = msg
  end
end

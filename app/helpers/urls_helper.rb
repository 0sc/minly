module UrlsHelper
  def show_in_list_format(urls)
    list = ''
    urls.each do |url|
      target = complete_shortened_link(url.shortened)
      list += "<li id='#{dom_id(url)}'>#{link_to(target, target, {target: "_blank"})}</li>"
    end
    "<ul>#{list}</ul>".html_safe
  end

  def complete_shortened_link(shortened)
    host_url + shortened
  end

  def display_notification(notification)
    return unless notification
    notice = ""
    notification.each do |class_tag, message|
      notice += "<li class='#{class_tag}'>#{message}</li>" unless class_tag.empty?
    end
    flash.discard #clear flash messages
    "<ul>#{notice}</ul>".html_safe
  end

  def header_message
    return "Hello, #{current_user.name}" if current_user
    "Urls You can remember!"
  end

  def header_tagline
    return "Let's make some minly's" if current_user
    "Create customized Urls for social media and adverts"
  end

  def get_fieldwidth
    current_user ? %w{four two two} :  %w{four three two}
  end
end

module UrlsHelper  
  def show_in_list_format(urls)
    list = ''
    urls.each do |url|
      target = host_url + url.shortened
      list += "<li id='#{dom_id(url)}'>#{link_to(target, target)}</li>"
    end
    "<ul>#{list}</ul>".html_safe
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

end

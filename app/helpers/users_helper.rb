module UsersHelper
  def default_statistics
    #Total Url Shortened
    #Total Active url
    #Total Inactive
  end

  def get_statistics (url)
    return unless url
    content = details_content_layout("Original", url.original, true, true)
    content << details_content_layout("Minly  ", complete_shortened_link(url.shortened), true, true)
    content << details_content_layout("Views", url.views, false, false)
    content << details_content_layout("Status", get_status(url.active), false, false)
    content
  end

  def details_content_layout(subject, desc, is_link = false, add_unshift = false)
    unshift = add_unshift ?  'unshift-left' : ""
    desc = link_to(desc, desc, {class: unshift, target: "_blank"}) if is_link
    content =  content_tag(:span,content_tag(:strong, subject), class: "two columns")
    content << content_tag(:span, desc, class: "ten columns")
    content = content_tag(:div, content, class: "row")
    content
  end

  def get_status (is_active)
    is_active ?  "Active" : "Inactive"
  end

  def show_url_details (url)
    result = get_statistics(url)
    @target_url = url
    result += render "urls/edit_form"
    result.html_safe
  end

  def list_user_urls (urls = current_user.urls.order("id desc"))
    list = ''
    urls.each do |url|
      target = host_url + url.shortened
      list += "<p id='#{dom_id(url)}'>#{target}</p>"
    end
    "#{list}".html_safe
  end

end

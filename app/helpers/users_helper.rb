module UsersHelper
  def default_statistics
    #Total Url Shortened
    #Total Active url
    #Total Inactive
  end

  def get_statistics (url)
    data = <<-EOS
      <p>
      <strong>Original</strong> #{link_to url.original, url.original, class: "unshift-left"}<br />
      <strong>Status</strong>  #{get_status(url.active)}<br />
      <strong>Views</strong> #{url.views}
      </p>
    EOS
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

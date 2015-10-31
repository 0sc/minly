module UsersHelper
  def default_statistics
    #Total Url Shortened
    #Total Active url
    #Total Inactive
  end

  def get_statistics (url)
    data = <<-EOS
      <p>
      <strong>Original</strong> #{link_to url.original, url.original}<br />
      <strong>Status</strong>  #{get_status(url.active)}<br />
      <strong>Views</strong> #{url.views}
      </p>
    EOS
    data.html_safe
  end

  def get_status (is_active)
    is_active ?  "Active" : "Inactive"
  end

  def list_user_urls (urls)
    list = ''
    urls.each do |url|
      target = host_url + url.shortened
      list += "<p id='#{dom_id(url)}'>#{link_to(target, target)}</p>"
    end
    "#{list}".html_safe
  end

end

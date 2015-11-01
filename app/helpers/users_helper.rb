module UsersHelper
  def default_statistics
    #Total Url Shortened
    #Total Active url
    #Total Inactive
  end

  def get_statistics (url)
    data = <<-EOS
      <p>Original: #{url.original}</p>
      <p>Status:  #{get_status(url.active)}</p>
      <p>Views: #{url.views}</p>
    EOS
    data.html_safe
  end

  def get_status (is_active)
    is_active ?  "Active" : "Inactive"
  end

end

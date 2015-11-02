module ApplicationHelper
  def host_url
    request.base_url + "/"
  end
end

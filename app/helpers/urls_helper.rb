module UrlsHelper
  def create_shortened_url (url_id)
      host_url + "/" + url_id.to_s(32).reverse
  end

  def host_url
    request.base_url
  end

  def sanitize_url(url)
    return if url.nil? || url.empty?
    url
  end
end

  # @url = Url.new(url_params)

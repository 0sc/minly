json.array!(@urls) do |url|
  json.extract! url, :id, :original, :redirect, :active
  json.url url_url(url, format: :json)
end

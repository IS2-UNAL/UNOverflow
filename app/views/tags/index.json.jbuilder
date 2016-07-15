json.array!(@tags) do |tag|
  json.extract! tag, :id, :title, :description
  json.url tag_url(tag, format: :json)
end

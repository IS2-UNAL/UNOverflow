json.array!(@tags) do |tag|
  json.extract! tag, :id, :title, :description, :post_id
  json.url tag_url(tag, format: :json)
end

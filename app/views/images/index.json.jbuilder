json.array!(@images) do |image|
  json.extract! image, :id, :image, :comment_id, :post_id
  json.url image_url(image, format: :json)
end

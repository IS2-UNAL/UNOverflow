json.array!(@likes_comments_by_users) do |likes_comments_by_user|
  json.extract! likes_comments_by_user, :id, :is_possitive, :user_id, :comment_id
  json.url likes_comments_by_user_url(likes_comments_by_user, format: :json)
end

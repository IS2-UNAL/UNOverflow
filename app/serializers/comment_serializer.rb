class CommentSerializer < ActiveModel::Serializer
  attributes :id, :answer,:created_at,:updated_at,:user_id,:post_id
  has_many :images
end

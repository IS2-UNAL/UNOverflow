class CommentSerializer < ActiveModel::Serializer
  attributes :id, :answer,:created_at,:updated_at
  has_many :images
end

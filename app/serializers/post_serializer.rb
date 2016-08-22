class PostSerializer < ActiveModel::Serializer
  attributes :id, :title,:description,:created_at,:updated_at
  has_many :comments
  has_many :images
end

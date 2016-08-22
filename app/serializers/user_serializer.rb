class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :auth_token
  has_many :comments
  has_many :post
end

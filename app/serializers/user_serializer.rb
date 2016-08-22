class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :auth_token, :avatar,:name,:role
  has_many :comments
  has_many :post
end

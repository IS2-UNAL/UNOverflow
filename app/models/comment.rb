class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :images
  has_many :likes_comments_by_users
  has_many :users, through: :likes_comments_by_users
end

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :likes_comments_by_users
  has_many :users, through: :likes_comments_by_users
  validates :answer, presence: true, length:{minimum:10}

end

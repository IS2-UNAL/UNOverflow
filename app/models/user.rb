class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, ImageUploader
  has_many :comments
  has_many :post
  has_many :likes_comments_by_users
  has_many :comments, through: :likes_comments_by_users
  enum role:{
    "User"  => 0,
    "Admin" => 1
  }
  validates :name, :username, :presence => true
  validates :email, :username, :uniqueness => true
  validates :role, :inclusion => roles.keys
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :zxcvbnable
end

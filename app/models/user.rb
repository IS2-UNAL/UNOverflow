class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, ImageUploader
  has_many :comments, dependent: :destroy
  has_many :post, dependent: :destroy
  has_many :likes_comments_by_users, dependent: :destroy
  has_many :comments, through: :likes_comments_by_users
  enum role:{
    "User"  => 0,
    "Admin" => 1
  }
  validates :name, :username, :avatar, :presence => true
  validates :email, :username, :uniqueness => true
  validates :role, :inclusion => roles.keys
  validates_processing_of :avatar
  validate :image_size_validation
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :zxcvbnable
  private
    def image_size_validation
      errors[:avatar] << "should be lees than 1MB" if avatar.size > 1.megabytes
    end
end

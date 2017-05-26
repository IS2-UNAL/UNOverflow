class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_create :generate_authentication_token!
  mount_uploader :avatar, ImageUploader
  has_many :comments, dependent: :destroy
  has_many :post, dependent: :destroy
  has_many :likes_comments_by_users, dependent: :destroy
  has_many :comments, through: :likes_comments_by_users
  has_many :tag_users, dependent: :destroy
  has_many :tags, through: :tag_users
  enum role:{
    "User"  => 0,
    "Admin" => 1
  }
  validates :auth_token, uniqueness: true
  validates :name, :username, :presence => true
  validates :email, :username, :uniqueness => true
  validates :role, :inclusion => roles.keys
  #validates_processing_of :avatar
  #validate :image_size_validation
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :zxcvbnable
  def self.userSuggest(username)
    where('username LIKE ?', "%#{username}%")
  end
  private
    def generate_authentication_token!
      begin
        self.auth_token = Devise.friendly_token
      end while self.class.exists?(auth_token: auth_token)
    end
    def image_size_validation
      errors[:avatar] << "should be lees than 1MB" if avatar.size > 1.megabytes
    end
end

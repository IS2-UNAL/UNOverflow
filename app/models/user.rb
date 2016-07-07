class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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

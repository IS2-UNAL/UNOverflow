class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :images
  has_and_belongs_to_many :tags
  validates :title,:description, presence: true
  validates :title, uniqueness: true
  validates :title, length: {in:5..250}
  validates :description, length: {minimum: 10}
end

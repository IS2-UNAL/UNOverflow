class Tag < ApplicationRecord
  has_and_belongs_to_many :posts
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :title, length: {in:5..250}
  validates :description, length: {minimum: 10}
end

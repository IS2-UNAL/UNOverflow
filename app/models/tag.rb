class Tag < ApplicationRecord
  has_and_belongs_to_many :posts
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :title, length: {in:1..250}
  validates :description, length: {minimum: 10}
  before_destroy :ensure_not_referenced_by_any_posts

  private
    def ensure_not_referenced_by_any_posts
      unless posts.empty?
        errors.add(:base,"This tag is used in some posts")
        throw :abort
      end
    end
end

class Tag < ApplicationRecord
  has_and_belongs_to_many :posts
  has_many :tag_users, dependent: :destroy
  has_many :users, through: :tag_users
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :title, length: {in:1..250}
  validates :description, length: {minimum: 10}
  before_destroy :ensure_not_referenced_by_any_posts

  def self.tagSuggest(title)
    where('title LIKE ?',"%#{title}%")
  end
  def self.tagSearch(page,search,order)
    where('title LIKE ?',"%#{search}%").paginate(:page => page,:per_page => 10).order("title #{order}")
  end
  private
    def ensure_not_referenced_by_any_posts
      unless posts.empty?
        errors.add(:base,"This tag is used in some posts")
        throw :abort
      end
    end
end

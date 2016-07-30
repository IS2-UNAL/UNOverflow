class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :images
  has_and_belongs_to_many :tags
  validates :title,:description, presence: true
  validates :title, uniqueness: true
  validates :title, length: {in:5..250}
  validates :description, length: {minimum: 10}

  def self.allPosts(page)
    all.paginate(:page => page,:per_page => 10).order("title ASC")
  end
  def self.postWithFilterDates(page,value)
    where("updated_at >= ? ", value).paginate(:page => page,:per_page => 10).order('title ASC')
  end
  def self.myPosts(page,value)
    where("user_id = ?",value).paginate(:page => page,:per_page => 10).order('title ASC')
  end
  def self.search(page,title)
    where("title LIKE ?","%#{title}%").paginate(:page => page,:per_page => 10).order('title ASC')
  end
  def self.searchDate(page,title,date)
    where("updated_at >= ? AND title LIKE ?",date, "%#{title}%").paginate(:page => page,:per_page => 10).order('title ASC')
  end
end

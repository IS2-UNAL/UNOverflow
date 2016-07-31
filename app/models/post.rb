class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
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
  def self.search(page,title,solved,noSolved)
    if (solved == "1" && noSolved == "1") || (solved == "0" && noSolved=="0")
      where("title LIKE ?","%#{title}%").paginate(:page => page,:per_page => 10).order('title ASC')
    elsif solved == "1"
      where("title LIKE ? AND is_solved = ?","%#{title}%",true).paginate(:page => page,:per_page => 10).order('title ASC')
    elsif noSolved == "1"
      where("title LIKE ? AND is_solved = ?","%#{title}%",false).paginate(:page => page,:per_page => 10).order('title ASC')
    end
  end
  def self.searchDate(page,title,date,solved,noSolved)
    if (solved == "1" && noSolved == "1") || (solved == "0" && noSolved=="0")
      where("updated_at >= ? AND title LIKE ?",date, "%#{title}%").paginate(:page => page,:per_page => 10).order('title ASC')
    elsif solved == "1"
      where("updated_at >= ? AND title LIKE ? AND is_solved = ?",date, "%#{title}%",true).paginate(:page => page,:per_page => 10).order('title ASC')
    elsif noSolved == "1"
      where("updated_at >= ? AND title LIKE ? AND is_solved = ?",date, "%#{title}%",true).paginate(:page => page,:per_page => 10).order('title ASC')
    end
  end
  def self.searchUser(page,user,solved,noSolved)
    if (solved == "1" && noSolved == "1") || (solved == "0" && noSolved=="0")
      where("user_id = ?",user).paginate(:page => page,:per_page=>10).order('title ASC')
    elsif solved == "1"
      where("user_id = ? AND is_solved = ?",user,true).paginate(:page => page,:per_page=>10).order('title ASC')
    elsif noSolved == "1"
      where("user_id = ? AND is_solved = ?",user,false).paginate(:page => page,:per_page=>10).order('title ASC')
    end
  end
  def self.searchUserDate(page,user,date,solved,noSolved)
    if (solved == "1" && noSolved == "1") || (solved == "0" && noSolved=="0")
      where("user_id = ? AND updated_at >= ?",user,date).paginate(:page=>page,:per_page=>10).order('title ASC')
    elsif solved == "1"
      where("user_id = ? AND updated_at >= ? AND is_solved = ?",user,date,true).paginate(:page=>page,:per_page=>10).order('title ASC')
    elsif noSolved == "1"
      where("user_id = ? AND updated_at >= ? AND is_solved = ?",user,date,false).paginate(:page=>page,:per_page=>10).order('title ASC')
    end
  end
end

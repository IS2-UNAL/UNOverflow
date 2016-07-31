class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :likes_comments_by_users
  has_many :users, through: :likes_comments_by_users, dependent: :destroy
  validates :answer, presence: true, length:{minimum:10}

  def possitiveComments
    i = 0
    self.likes_comments_by_users.each do |a|
      if a.is_possitive
        i += 1
      end
    end
    i
  end
  def userVoted?(user)
    self.likes_comments_by_users.each do |a|
      if a.user == user
        return true
      end
    end
    return false
  end
  def like?(user)
    self.likes_comments_by_users.each do |a|
      if a.user == user
        return a.is_possitive
      end
    end
  end
  def negativeComments
    i = 0
    self.likes_comments_by_users.each do |a|
      unless a.is_possitive
        i += 1
      end
    end
    i
  end

end

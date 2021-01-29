class Post < ApplicationRecord
  acts_as_taggable 
  belongs_to :user
  has_one_attached :image
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :likes, dependent: :destroy

  def self.search(search)
    if search != ""
      Post.where('title LIKE(?)', "%#{search}%")
    end
  end
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end

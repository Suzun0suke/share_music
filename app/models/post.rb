class Post < ApplicationRecord
  acts_as_taggable 
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :musics, through: :playlists
  
  def self.search(search)
    if search != ""
      post = Post.where('title LIKE(?)', "%#{search}%")
      tag = Post.tagged_with([search], wild: true, any: true)
      post | tag
    end
  end
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end

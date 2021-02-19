class Post < ApplicationRecord
  acts_as_taggable 
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :musics, through: :playlists
  
  with_options presence: true do
    validates :title
    validates :image
    validates :url, format: {with: /https?:\/\/open.spotify.com\/playlist\/[a-zA-Z0-9]{22}\?si=[a-zA-Z0-9]{16}/}
  end
  
  def self.search(search)
    if search != ""
      post = Post.where('title LIKE(?)', "%#{search}%")
      tag = Post.tagged_with([search], wild: true, any: true)
      music = Post.joins(:musics).where('track LIKE(?)', "%#{search}%")
      
      post | tag | music
    end
  end
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end

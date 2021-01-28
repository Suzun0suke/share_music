class Post < ApplicationRecord
  acts_as_taggable 
  belongs_to :user
  has_one_attached :image
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  def self.search(search)
    if search != ""
      Post.where('title LIKE(?)', "%#{search}%")
    end
  end
end

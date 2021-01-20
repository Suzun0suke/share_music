class Post < ApplicationRecord
  acts_as_taggable 
  belongs_to :user
  has_one_attached :image
  has_many :post_tags
  has_many :tags, through: :post_tags

  def self.search(search)
    if search != ""
      Post.where('title LIKE(?)', "%#{search}%")
    end
  end
end

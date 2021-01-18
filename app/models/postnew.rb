class Postnew 
  include ActiveModel::Model
  attr_accessor :title, :url, :name, :image, :user_id

  with_options presence: true do
    validates :title
    validates :url
  end

  def save
    post = Post.create(title: title, url: url, image: image, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    PostTag.create(post_id: post.id, tag_id: tag.id)
  end
end

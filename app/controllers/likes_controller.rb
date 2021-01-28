class LikesController < ApplicationController
  before_action :set_post
  def create
    like = current_user.likes.new(post_id: @post.id)
    like.save
  end

  def destroy
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
    @id_name = "#like-link-#{@post.id}"
  end
end

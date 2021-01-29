class LikesController < ApplicationController
  before_action :set_post
  def create
    like = @post.likes.new(user_id: current_user.id)
    like.save
    redirect_to root_path
  end

  def destroy
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
    redirect_to root_path
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
    @id_name = "#like-link-#{@post.id}"
  end
end

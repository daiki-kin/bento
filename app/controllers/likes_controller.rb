class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.likes.create(post: @post)
    redirect_back fallback_location: root_path
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: @post)
    like.destroy if like
    redirect_back fallback_location: root_path
  end
end

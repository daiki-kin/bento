class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post.likes.create(user: current_user)
    redirect_back fallback_location: root_path
  end

  def destroy
    like = @post.likes.find_by(user: current_user)
    like.destroy if like
    redirect_back fallback_location: root_path
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path, alert: "ユーザーが見つかりません"
      return
    end

    @posts = @user.posts.with_attached_post_image.page(params[:page]).per(8)
  end

  def liked_posts
    @user = current_user
    @liked_posts = @user.liked_posts # いいね機能がある場合
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "ユーザー登録が完了しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def liked_posts
    @user = User.find(params[:id])
    @liked_posts = @user.liked_posts.includes(:post_image_attachment)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :terms_of_service, :privacy_policy)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

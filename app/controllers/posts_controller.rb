class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to user_path(current_user), notice: '投稿が完了しました'
        else
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to @post, notice: "投稿を更新しました"
        else
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to user_path(current_user), notice: "投稿を削除しました"
    end

    def liked_posts
        @liked_posts = current_user.liked_posts
    end

    private

    def post_params
        params.require(:post).permit(:store_name, :review, :address, :rating, :post_image)
    end
end

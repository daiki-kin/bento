class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @posts = Post.includes(:likes, post_image_attachment: :blob)

        # キーワード検索
        if params[:keyword].present?
            @posts = @posts.where("store_name LIKE ? OR review LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
        end

        # 星評価で絞り込み
        if params[:rating].present?
            @posts = @posts.where("rating >= ?", params[:rating].to_i)
        end

        # いいね数でソート
        if params[:likes_sort].present?
            order_direction = params[:likes_sort] == "asc" ? :asc : :desc
            @posts = @posts.order(likes_count: order_direction)
        else
            @posts = @posts.order(created_at: :desc)
        end

        # ページネーション
        @posts = @posts.page(params[:page]).per(8)
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
          respond_to do |format|
            format.turbo_stream
            format.html { redirect_to user_path(current_user), notice: '投稿が完了しました' }
          end
        else
          respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.replace("post_form", partial: "posts/form", locals: { post: @post }), status: :unprocessable_entity }
            format.html { render :new, status: :unprocessable_entity }
          end
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

    def search
        posts = Post.all
        posts = posts.where.not(latitude: nil, longitude: nil)

        if params[:keyword].present?
            posts = posts.where("store_name LIKE ? OR review LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
        end

        if params[:rating].present?
            posts = posts.where("rating >= ?", params[:rating].to_i)
        end

        if params[:likes_sort] == "desc"
            posts = posts.order(likes_count: :desc)
        elsif params[:likes_sort] == "asc"
            posts = posts.order(likes_count: :asc)
        end

        render json: posts.map { |post|
            {
                id: post.id,
                name: post.store_name,
                comment: post.review,
                latitude: post.latitude,
                longitude: post.longitude,
                image_url: post.post_image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(post.post_image, only_path: true) : ActionController::Base.helpers.asset_path("default_image.png")
            }
        }
    end

    def map_search
        @posts = Post.where.not(latitude: nil, longitude: nil)
    end

    private

    def post_params
        params.require(:post).permit(:store_name, :review, :address, :rating, :post_image)
    end
end

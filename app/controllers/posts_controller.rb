class PostsController < ApplicationController
    # ユーザー認証を除外するアクションを指定
    before_action :authenticate_user!, except: [ :index, :show, :search, :map_search, :monthly_ranking ]

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
        @post.rating ||= 3
    end

    def show
        @post = Post.find(params[:id])
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to root_path, notice: "投稿が完了しました"
        else
            puts @post.errors.full_messages
            render :new, status: :unprocessable_entity
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


    def monthly_ranking
        start_of_month = Time.current.beginning_of_month
        end_of_month   = Time.current.end_of_month
        # 月間ランキングの取得
        # いいね数でソートし、上位10件を取得
        @monthly_posts = Post
            .joins(:likes)
            .where(likes: { created_at: start_of_month..end_of_month })
            .group("posts.id")
            .select("posts.*, COUNT(likes.id) AS likes_count")
            .order("likes_count DESC")
            .limit(10)  # 上位10件を表示
    end

    private

    def post_params
        params.require(:post).permit(:store_name, :review, :address, :rating, :post_image)
    end
end

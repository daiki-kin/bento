require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:user) do
    User.create!(
      email: "test@example.com",
      name: "テストユーザー",
      password: "password",
      password_confirmation: "password"
    )
  end

  let!(:post_record) do
    Post.create!(
      store_name: "テスト店舗",
      review: "テストレビュー",
      rating: 3,
      user: user
    )
  end

  describe "GET /posts" do
    it "一覧画面にアクセスできる" do
      get posts_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /posts/:id" do
    it "詳細画面にアクセスできる" do
      get post_path(post_record)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /posts/new" do
    it "新規作成画面にアクセスできる" do
      sign_in user
      get new_post_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /posts" do
    it "記事を作成できる" do
      sign_in user
      expect {
        post posts_path, params: {
          post: {
            store_name: "新しいお店",
            review: "新規レビュー",
            rating: 4
          }
        }
      }.to change(Post, :count).by(1)
      follow_redirect!
      expect(response.body).to include("新規レビュー")
    end
  end

  describe "GET /posts/:id/edit" do
    it "編集画面にアクセスできる" do
      sign_in user
      get edit_post_path(post_record)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /posts/:id" do
    it "記事を更新できる" do
      sign_in user
      patch post_path(post_record), params: {
        post: {
          store_name: "更新されたお店名"
        }
      }
      follow_redirect!
      expect(response.body).to include("更新されたお店名")
    end
  end

  describe "DELETE /posts/:id" do
    it "記事を削除できる" do
      sign_in user
      expect {
        delete post_path(post_record)
      }.to change(Post, :count).by(-1)
    end
  end
end

require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let!(:article) { Article.create(title: "既存記事", content: "既存の本文") }

  describe "GET /articles" do
    it "一覧画面にアクセスできる" do
      get articles_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /articles/:id" do
    it "詳細画面にアクセスできる" do
      get article_path(article)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /articles/new" do
    it "新規作成画面にアクセスできる" do
      get new_article_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /articles" do
    it "記事を作成できる" do
      post articles_path, params: { article: { title: "新規記事", content: "新規本文" } }
      expect(response).to have_http_status(:found) # リダイレクト
      follow_redirect!
      expect(response.body).to include("新規記事")
    end
  end

  describe "GET /articles/:id/edit" do
    it "編集画面にアクセスできる" do
      get edit_article_path(article)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /articles/:id" do
    it "記事を更新できる" do
      patch article_path(article), params: { article: { title: "更新タイトル" } }
      expect(response).to have_http_status(:found) # リダイレクト
      follow_redirect!
      expect(response.body).to include("更新タイトル")
    end
  end

  describe "DELETE /articles/:id" do
    it "記事を削除できる" do
      expect {
        delete article_path(article)
      }.to change(Article, :count).by(-1)
      expect(response).to have_http_status(:found)
    end
  end
end

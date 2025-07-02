require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'バリデーション' do
    it 'タイトルと本文があれば有効である' do
      article = Article.new(title: 'テストタイトル', content: 'テスト本文')
      expect(article).to be_valid
    end

    it 'タイトルがなければ無効である' do
      article = Article.new(title: nil, content: 'テスト本文')
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it '本文がなければ無効である' do
      article = Article.new(title: 'テストタイトル', content: nil)
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end
  end
end

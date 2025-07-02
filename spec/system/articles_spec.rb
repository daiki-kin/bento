require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  it '記事を新規作成して表示する' do
    visit new_article_path

    fill_in 'Title', with: 'RSpecシステムテスト'
    fill_in 'Content', with: 'RSpecでシステムテストを実施しています'
    click_button 'Create Article'

    expect(page).to have_content('Article was successfully created')
    expect(page).to have_content('RSpecシステムテスト')
    expect(page).to have_content('RSpecでシステムテストを実施しています')
  end
end

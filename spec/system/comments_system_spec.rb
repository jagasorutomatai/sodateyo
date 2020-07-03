require 'rails_helper'

RSpec.describe Like, type: :system do
  let!(:user) { create :user }
  let!(:other) { create :other}
  let!(:kanagawa) { create :prefecture, name: '神奈川県'}
  let!(:post1) { create(:post1, user:other, prefecture:kanagawa) }
  describe 'コメント投稿' do
    context 'コメントしたとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on '植物を検索'
            click_on post1['title']
            fill_in 'comment_content', with: 'コメントのテストです'
            click_on '追加する'
        end
        it 'コメントの件数が1件である' do
            expect(page).to have_selector '.comments_count', text: '1件のコメント'
        end
        it 'コメントしたユーザーが表示される' do
            expect(page).to have_content 'testuser'
        end
        it '投稿したコメントが表示される' do
            expect(page).to have_content 'コメントのテストです'
        end
    end
  end
end
require 'rails_helper'

RSpec.describe Like, type: :system do
  let!(:user) { create :user }
  let!(:other) { create :other}
  let!(:kanagawa) { create :prefecture, name: '神奈川県'}
  let!(:post1) { create(:post1, user:other, prefecture:kanagawa) }
  describe 'いいね〜いいねを外す' do
    context 'いいねしたとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on '投稿を検索'
            click_on post1['title']
            click_on 'like_btn'
        end
        it 'いいねの数が1である' do
            expect(page).to have_selector '#likes', text: '1'
        end
        it 'いいねを外すボタンに切り替わっている' do
            expect(page).to_not have_button '#like_btn'
        end
    end
    context 'いいねを外したとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on '投稿を検索'
            click_on post1['title']
            click_on 'like_btn'
            click_on 'unlike_btn'
        end
        it 'いいねの数が1である' do
            expect(page).to have_selector '#likes', text: '0'
        end
        it 'いいねを外すボタンに切り替わっている' do
            expect(page).to_not have_button '#unlike_btn'
        end
    end
  end
end
require 'rails_helper'

RSpec.describe Relationship, type: :system do
  let!(:user) { create :user }
  let!(:other) { create :other}
  let!(:kanagawa) { create :prefecture, name: '神奈川県'}
  let!(:post1) { create(:post1, user:other, prefecture:kanagawa) }
  describe 'フォロー〜アンフォロ' do
    context '別のユーザーをフォローをしたとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on '投稿を検索'
            click_on other['name']
            click_on 'フォロー'
        end
        it 'フォローワーの数が1である' do
            expect(page).to have_selector '#followers', text: '1'
        end
        it 'フォローするボタンが切り替わっている' do
            expect(page).to_not have_button 'フォロー'
            expect(page).to have_button 'フォローを外す'
        end
    end

    context '別のユーザーをアンフォローをしたとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on '投稿を検索'
            click_on other['name']
            click_on 'フォロー'
            click_on 'フォローを外す'
        end
        it 'フォローワーの数が0である' do
            expect(page).to have_selector '#followers', text: '0'
        end
        it 'フォローするボタンが切り替わっている' do
            expect(page).to_not have_button 'フォローを外す'
            expect(page).to have_button 'フォロー'
        end
    end

    context '別のユーザーをアンフォローをしたとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on '投稿を検索'
            click_on other['name']
            click_on 'フォロー'
            click_on 'フォローを外す'
        end
        it 'フォローワーの数が0である' do
            expect(page).to have_selector '#followers', text: '0'
        end
        it 'フォローするボタンが切り替わっている' do
            expect(page).to_not have_button 'フォローを外す'
            expect(page).to have_button 'フォロー'
        end
    end
  end
end
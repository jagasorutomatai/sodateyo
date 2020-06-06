require 'rails_helper'

RSpec.describe User, type: :system do
  include SystemSupport
  let(:user) { create :user }
  EDITED_USER_NAME = 'editedtestuser'.freeze
  EDITED_USER_EMAIL = 'editedtestuser@sample.com'.freeze
  describe 'ユーザー編集処理' do
    context '予めログインしているとき' do
      before do
        log_in_as user
        visit edit_user_path(user)
      end
      context '無効な値を入力したとき' do
        before do
          fill_in 'user_name', with: ''
          fill_in 'user_email', with: ''
          fill_in 'user_password', with: ''
          fill_in 'user_password_confirmation', with: ''
          click_on '変更を保存する'
        end

        it 'ユーザー編集ページが表示される' do
          expect(current_path).to eq "/users/#{user.id}"
        end
      end

      context '有効な値を入力した時' do
        before do
          fill_in 'user_name', with: EDITED_USER_NAME
          fill_in 'user_email', with: EDITED_USER_EMAIL
          fill_in 'user_password', with: ''
          fill_in 'user_password_confirmation', with: ''
          click_on '変更を保存する'
          user.reload
        end

        it 'ユーザー編集画面が表示される' do
          expect(current_path).to eq "/users/#{user.id}"
        end

        it 'フラッシュメッセージが表示される' do
          expect(page).to have_selector('.alert-success', text: 'ユーザーの情報を変更しました')
        end

        it '変更が反映されている' do
          expect(user.name).to eq EDITED_USER_NAME
          expect(user.email).to eq EDITED_USER_EMAIL
        end
      end
    end

    context '予めログインしてないとき' do
      before do
        user
        visit edit_user_path(user)
      end

      it 'ログインページに遷移する' do
        expect(current_path).to eq login_path
      end

      it 'フラッシュメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: 'ログインしてください')
      end

      context 'ログインしたとき' do
        before do
          log_in_as user
        end

        it 'ユーザー編集ページに遷移する' do
          edit_user_path(user)
        end

        it 'フラッシュメッセージが表示されない' do
          expect(page).to_not have_selector('.alert-danger', text: 'ログインしてください')
        end
      end
    end
  end
end

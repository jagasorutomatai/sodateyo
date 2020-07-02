# ユーザー作成〜編集〜削除までの総合テスト

require 'rails_helper'

RSpec.describe User, type: :system do
  let!(:users) { create_list :users, 30 }
  describe 'ユーザー作成〜編集〜削除処理' do
    context 'ユーザー作成フォームで正常な値を入力したとき' do
      before do
        visit signup_path
        fill_in 'user_name', with: 'testuser'
        fill_in 'user_email', with: 'testuser@sample.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント作成'
        click_on 'testuser'
      end
      it 'フラッシュメッセージが表示される' do
        expect(page).to have_selector('.alert-success', text: 'アカウントの登録が完了しました')
      end
      it 'ユーザーの名前が表示される' do
        expect(page).to have_content 'testuser'
      end
      it 'ログインのリンクが表示されない' do
        expect(page).to_not have_link 'ログイン', href: '/login'
      end
      it 'ログアウトのリンクが表示される' do
        expect(page).to have_link 'ログアウト', href: '/logout'
      end
    end

    context 'ユーザー作成フォームで異常な値を入力したとき' do
      before do
        visit signup_path
        fill_in 'user_name', with: ''
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: ''
        click_on 'アカウント作成'
      end
      it 'ユーザー作成画面が表示される' do
        expect(current_path).to eq signup_path
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: '名前を入力してください')
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: 'メールアドレスを入力してください')
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: 'メールアドレスは不正な値です')
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: 'パスワードを入力してください')
      end
    end

    context 'ユーザー編集フォームで正常な値を入力したとき' do
      before do
        visit signup_path
        fill_in 'user_name', with: 'testuser'
        fill_in 'user_email', with: 'testuser@sample.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント作成'
        click_on 'testuser'
        click_on '設定'
        fill_in 'user_name', with: 'editedtestuser'
        fill_in 'user_email', with: 'editedtestuser@sample.com'
        click_on '変更を保存する'
      end
      it 'フラッシュメッセージが表示される' do
        expect(page).to have_selector('.alert-success', text: 'ユーザーの情報を変更しました')
      end
      it 'ユーザーの名前が変更されている' do
        expect(page).to have_content 'editedtestuser'
      end
    end

    context 'ユーザー編集フォームで異常な値を入力したとき' do
      before do
        visit signup_path
        fill_in 'user_name', with: 'testuser'
        fill_in 'user_email', with: 'testuser@sample.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント作成'
        click_on 'testuser'
        click_on '設定'
        fill_in 'user_name', with: ''
        fill_in 'user_email', with: ''
        click_on '変更を保存する'
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: '名前を入力してください')
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: 'メールアドレスを入力してください')
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: 'メールアドレスは不正な値です')
      end
    end
  end
end

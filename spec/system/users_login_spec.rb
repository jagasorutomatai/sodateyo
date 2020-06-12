require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { create :user }
  before { user }
  describe 'ログイン処理' do
    context '無効な値を入力したとき' do
      before do
        visit login_path
        fill_in 'session_email', with: ''
        fill_in 'session_password', with: ''
        click_on 'ログインする'
      end

      it 'ログイン画面が表示される' do
        expect(current_path).to eq login_path
      end

      it 'フラッシュメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: 'メールアドレス/パスワードが間違っています')
      end

      context '他のページに遷移したとき' do
        before do
          visit root_path
        end
        it 'フラッシュメッセージが表示されない' do
          expect(page).to_not have_selector('.alert-danger', text: 'メールアドレス/パスワードが間違っています')
        end
      end
    end

    context '有効な値を入力したとき' do
      before do
        visit login_path
        fill_in 'session_email', with: 'testuser@sample.com'
        fill_in 'session_password', with: 'password'
        check 'ログイン情報を記憶する'
        click_on 'ログインする'
        click_on 'アカウント'
      end

      it 'ログインのリンクが表示されない' do
        expect(page).to_not have_link 'ログイン', href: '/login'
      end

      it 'ログアウトのリンクが表示される' do
        expect(page).to have_link 'ログアウト', href: '/logout'
      end

      it 'Cookiesにログイン情報が保存される' do
        cookies = page.driver.browser.manage.all_cookies
        expect(cookies.count).to_not eq 1
      end
    end
  end
end
# loginからlogoutまでの総合テスト

require 'rails_helper'

RSpec.describe User, type: :system do
  let!(:user) { create :user }
  describe 'ログイン-ログアウト処理' do
    context 'ログインフォームで正常な値を入力したとき' do
        before do
          visit login_path
          fill_in 'session_email', with: 'testuser@sample.com'
          fill_in 'session_password', with: 'password'
          check 'ログイン情報を記憶する'
          click_on 'ログインする'
          click_on 'testuser'
        end
  
        it 'ログインのリンクが表示されない' do
          expect(page).to_not have_link 'ログイン', href: '/login'
        end
  
        it 'ログアウトのリンクが表示される' do
          expect(page).to have_link 'ログアウト', href: '/logout'
        end
  
        # _sodateyo_session
        it 'Cookiesにログイン情報が保存される' do
          cookies = page.driver.browser.manage.all_cookies
          expect(cookies.count).to eq 3
        end
    end

    context 'ログインフォームで正常な値を入力した後ログアウトしたとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on 'testuser'
            click_on 'ログアウト'
        end

        it 'ルートに遷移する' do
            expect(current_path).to eq root_path
        end

        it 'ログインのリンクが表示される' do
            expect(page).to have_link 'ログイン', href: '/login'
        end

        it 'ログアウトのリンクが表示されない' do
            expect(page).to_not have_link 'ログアウト', href: '/logout'
        end
    end

    context 'ログインフォームで異常な値を入力したとき' do
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
    end

    context 'ログイン失敗後に他のページに遷移したとき' do
        before do
            visit login_path
            fill_in 'session_email', with: ''
            fill_in 'session_password', with: ''
            click_on 'ログインする'
            visit root_path
        end
        it 'フラッシュメッセージが表示されない' do
            expect(page).to_not have_selector('.alert-danger', text: 'メールアドレス/パスワードが間違っています')
        end
    end
  end
end
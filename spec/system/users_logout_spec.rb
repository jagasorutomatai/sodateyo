require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { create :user }
  before { user }
  describe 'ログアウト処理' do
    context 'ログアウトをしたとき' do
      before do
        visit login_path
        fill_in 'session_email', with: 'testuser@sample.com'
        fill_in 'session_password', with: 'password'
        click_on 'ログインする'
        click_on 'アカウント'
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
  end
end

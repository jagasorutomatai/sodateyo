require 'rails_helper'

RSpec.describe User, type: :system do
  include SystemSupport
  let(:user) { create :user }
  let(:users) { create_list :users, 30 }
  before do
    user
    users
  end
  describe 'ユーザー一覧表示' do
    context 'ログインしているとき' do
      before do
        log_in_as user
        visit users_path
      end
      it 'ページネーションが表示されている' do
        expect(page).to have_selector '.pagination'
      end
      it 'ユーザーの詳細ページへのリンクが表示される' do
        User.page(1).each do |user|
          expect(page).to have_link '詳細ページ', href: "/users/#{user.id}"
        end
      end
    end
  end
end

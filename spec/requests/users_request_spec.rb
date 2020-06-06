require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include RequestSupport
  let(:user) { FactoryBot.build :user }
  let(:other) { FactoryBot.create :other }
  let(:admin) { FactoryBot.create :admin }
  before do
    user
    other
    admin
  end

  describe 'GET #index' do
    context 'ログインしていないとき' do
      before { get users_path }
      it 'ログインページにリダイレクトされる' do
        expect(response).to redirect_to(login_url)
      end
    end
  end

  describe 'GET #new' do
    context '有効なリクエストのとき' do
      it 'HTTPのレスポンスが200 successとなる' do
        get signup_path
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'POST #create' do
    context '有効なリクエストのとき' do
      before do
        post signup_path, params: { user: { name: 'testuser',
                                            email: 'testuser@sample.com',
                                            password: 'password',
                                            password_confirmation: 'password' } }
      end
      it 'HTTPのレスポンスが200 successとなる' do
        expect(User.count).to eq 3
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしてないとき' do
      let(:user) { FactoryBot.create :user }
      before do
        get "/users/#{user.id}/edit"
      end
      it 'ログイン画面にリダイレクトされる' do
        expect(response).to redirect_to(login_url)
      end
    end

    context '別のアカウントでログインしているとき' do
      let(:user) { FactoryBot.create :user }
      before do
        log_in_as other
        get "/users/#{user.id}/edit"
      end
      it 'ログイン画面にリダイレクトされる' do
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログインしてないとき' do
      let(:user) { FactoryBot.create :user }
      before do
        get "/users/#{user.id}/edit"
        patch "/users/#{user.id}", params: { user: { name: user.name, email: user.email } }
      end
      it 'ログイン画面にリダイレクトされる' do
        expect(response).to redirect_to(login_url)
      end
    end

    context 'ログインしているとき' do
      let(:user) { FactoryBot.create :user }
      before do
        log_in_as user
      end

      context 'admin属性も同時に送信していないとき' do
        before do
          get "/users/#{user.id}/edit"
          patch "/users/#{user.id}", params: { user: { name: 'editedtestuser', email: user.email } }
          user.reload
        end
        it 'ユーザーの情報が更新されている' do
          expect(user.name).to eq 'editedtestuser'
        end
      end

      context 'admin属性も同時に送信したとき' do
        before do
          get "/users/#{user.id}/edit"
          patch "/users/#{user.id}", params: { user: { name: 'editedtestuser', email: user.email, admin: false } }
          user.reload
        end
        it 'admin属性が更新されてない' do
          expect(user.admin).to_not eq false
        end
      end
    end

    context '別のアカウントでログインしているとき' do
      let(:user) { FactoryBot.create :user }
      before do
        log_in_as other
        get "/users/#{user.id}/edit"
        patch "/users/#{user.id}", params: { user: { name: user.name, email: user.email } }
      end
      it 'ルートにリダイレクトされる' do
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしてないとき' do
      let(:user) { FactoryBot.create :user }
      before do
        delete "/users/#{user.id}"
      end
      it 'ログインページにリダイレクトされる' do
        expect(response).to redirect_to(login_url)
      end
    end

    context 'ログインしているとき' do
      let(:user) { FactoryBot.create :user }
      before do
        user
        log_in_as other
      end
      context '管理者権限を持っていないとき' do
        before do
          delete "/users/#{user.id}"
        end
        it 'ルートにリダイレクトされる' do
          expect(response).to redirect_to(root_url)
        end
      end
    end
  end
end

"""
・Webリクエストが成功したか
・正しいページにリダイレクトされたか
・ユーザー認証が成功したか
・ビューに表示されたメッセージは適切か
"""

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include RequestSupport
  let!(:user) { FactoryBot.build :user }
  let!(:other) { FactoryBot.create :other }
  let!(:admin) { FactoryBot.create :admin }

  describe 'GET #new' do
    context '有効なリクエストのとき' do
      before do
        get signup_path
      end
      it 'HTTPレスポンスステータスコードが 200 OK となる' do
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'POST #create' do
    let!(:count) { User.count }
    context '有効なリクエストのとき' do
      before do
        post signup_path, params: { user: { name: 'testuser',
                                            email: 'testuser@sample.com',
                                            password: 'password',
                                            password_confirmation: 'password' } }
      end
      it 'HTTPレスポンスステータスコードが 302 Found となる' do
        expect(response).to have_http_status 302
      end
      it 'DBに登録されているユーザー数が1つ増えてる' do
        expect(User.count).to eq (count + 1)
      end
      it 'flashメッセージが表示される' do
        expect(flash[:success]).to eq 'アカウントの登録が完了しました'
      end
    end

    context '無効なリクエストのとき' do
      before do
        post signup_path, params: { user: { name: '',
                                            email: '',
                                            password: '',
                                            password_confirmation: '' } }
      end
      it 'ユーザー作成画面に戻る' do
        expect(request.fullpath).to eq signup_path
      end
    end
  end

  describe 'GET #edit' do
    let!(:user) { FactoryBot.create :user }
    context 'ログインしているとき' do
      before do
        log_in_as user
      end
      context '有効なリクエストのとき' do
        before do
          get "/users/#{user.id}/edit"
        end
        it 'HTTPレスポンスステータスコードが 200 OK となる' do
          expect(response).to have_http_status 200
        end
      end
    end

    context 'ログインしてないとき' do
      before do
        get "/users/#{user.id}/edit"
      end
      it 'ログイン画面にリダイレクトされる' do
        expect(response).to redirect_to(login_url)
      end
    end

    context '別のアカウントでログインしているとき' do
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
    context 'ログインしているとき' do
      let(:user) { FactoryBot.create :user }
      before do
        log_in_as user
      end
      context '有効なリクエストのとき' do
        before do
          patch "/users/#{user.id}", params: { user: { name: 'editedtestuser', email: user.email } }
          user.reload
        end
        it 'ユーザーの情報が更新されている' do
          expect(user.name).to eq 'editedtestuser'
        end
      end

      context '無効なリクエストのとき' do
        context '空文字のとき' do
          before do
            patch "/users/#{user.id}", params: { user: { name: '', email: '' } }
            user.reload
          end
          it 'ユーザー編集画面に戻る' do
            expect(request.fullpath).to eq user_path(user)
          end
          it 'ユーザーの情報が更新されてない' do
            expect(user.name).to_not eq ''
          end
        end
        
        context 'admin属性も変更しようとしたとき' do
          before do
            patch "/users/#{user.id}", params: { user: { name: 'editedtestuser', email: user.email, admin: false } }
          end
          it 'ユーザー編集画面に戻る' do
            expect(request.fullpath).to eq user_path(user)
          end
          it 'admin属性が更新されてない' do
            expect(user.admin).to_not eq false
          end
        end
      end
    end

    context 'ログインしてないとき' do
      let(:user) { FactoryBot.create :user }
      before do
        patch "/users/#{user.id}", params: { user: { name: user.name, email: user.email } }
      end
      it 'ログイン画面にリダイレクトされる' do
        expect(response).to redirect_to(login_url)
      end
    end

    context '別のアカウントでログインしているとき' do
      let(:user) { FactoryBot.create :user }
      before do
        log_in_as other
        patch "/users/#{user.id}", params: { user: { name: user.name, email: user.email } }
      end
      it 'ルートにリダイレクトされる' do
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { FactoryBot.create :user }
    context '管理者権限があるユーザーでログインしているとき' do
      before do
        log_in_as admin
      end
      context '有効なリクエストのとき' do
        before do
          delete "/users/#{user.id}"
        end
        it 'HTTPレスポンスステータスコードが 200 OK となる' do
          expect(response).to have_http_status 302
        end
        it 'ルートにリダイレクトされる' do
          expect(response).to redirect_to(users_url)
        end
      end
    end

    context '管理者権限がないユーザーでログインしているとき' do
      before do
        log_in_as other
        delete "/users/#{user.id}"
      end
      it 'ルートにリダイレクトされる' do
        expect(response).to redirect_to(root_url)
      end
    end

    context 'ログインしてないとき' do
      before do
        delete "/users/#{user.id}"
      end
      it 'ログインページにリダイレクトされる' do
        expect(response).to redirect_to(login_url)
      end
    end
  end
end

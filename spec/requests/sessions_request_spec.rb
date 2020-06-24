"""
・Webリクエストが成功したか
・正しいページにリダイレクトされたか
・ユーザー認証が成功したか
・ビューに表示されたメッセージは適切か
"""


require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  include RequestSupport
  let!(:user) { FactoryBot.create :user }
  before { user }
  describe 'GET #new' do
    context '有効なリクエストのとき' do
      before do
        get login_path
      end
      it 'HTTPレスポンスステータスが 200 OK となる' do
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'POST #create' do
    context '有効なリクエストのとき' do
      before do
        post login_path, params: { session: { email: user.email, password: user.password, remember_me: '1' } }
      end
      it 'HTTPレスポンスステータスコードが 200 ok となる' do
        expect(response).to have_http_status 200
      end
    end

    context '無効なリクエストのとき' do
      before do
        post login_path, params: { session: { email: '', password: '', remember_me: '0' } }
      end
      it 'ログイン画面に戻る' do
        expect(request.fullpath).to eq login_path
      end
      it 'flashメッセージが表示される' do
        expect(flash[:danger]).to eq 'メールアドレス/パスワードが間違っています'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしているとき' do
      before do
        log_in_as user
      end
      context '有効なリクエストのとき' do
        before do
          delete logout_path
        end
        it 'HTTPレスポンスステータスコードが 302 Found となる' do
          expect(response).to have_http_status 302
        end
        it 'ルートにリダイレクトされる' do
          expect(response).to redirect_to(root_url)
        end
      end
    end

    context 'ログインしていないとき' do
      before do
        delete logout_path
      end
      it 'ルートにリダイレクトされる' do
        expect(response).to redirect_to(root_url)
      end
    end
  end
end

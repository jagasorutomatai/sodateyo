require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { FactoryBot.create :user }
  before { user }
  describe 'GET #new' do
    context '有効なリクエストのとき' do
      it 'HTTPのレスポンスが200 successとなる' do
        get login_path
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'POST #create' do
    context '有効なリクエストのとき' do
      it 'HTTPのレスポンスが200 successとなる' do
        post login_path, params: { session: { email: user.email, password: user.password, remember_me: '1' } }
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしている状態でDELETEリクエスがきたとき' do
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
        delete logout_path
      end

      it 'HTTPのレスポンスが302 successとなる' do
        expect(response).to have_http_status 302
      end

      it 'ルートにリダイレクトされる' do
        expect(response).to redirect_to(root_url)
      end
    end

    context 'ログインしてない状態でDELETEリクエスがきたとき' do
      before { delete logout_path }
      it 'ルートにリダイレクトされる' do
        expect(response).to redirect_to(root_url)
      end
    end
  end
end

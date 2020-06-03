require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { FactoryBot.create :user }

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
        post login_path, params: { session: { email: user.email, passoword: user.password } }
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'DELETE #destroy' do
    context '有効なリクエストのとき' do
      before do
        post login_path, params: { session: { email: user.email, passoword: user.password } }
      end
      it 'HTTPのレスポンスが302 successとなる' do
        delete logout_path
        expect(response).to have_http_status 302
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Users', type: :request do
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
      it 'HTTPのレスポンスが200 successとなる' do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Plants', type: :request do
  include RequestSupport
  let(:plant) { create :plant }
  let(:admin) { create :admin }
  before do
    plant
    admin
    log_in_as admin
  end
  describe 'GET #new' do
    context '有効なリクエストのとき' do
      before do
        get new_plant_path
      end
      it 'HTTPのレスポンスが200 successとなる' do
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'POST #create' do
    context '有効なリクエストのとき' do
      before do
        post plants_path, params: { plant: { name: 'testplantname',
                                             description: 'testplantdescription',
                                             picture: 'logo.jpg' } }
      end
      it 'フラッシュメッセージが存在する' do
        expect(flash.empty?).to be true
      end
      it 'plantが一個増える' do
        expect(User.count).to eq 1
      end
    end
  end

  describe 'GET #edit' do
    context '有効なリクエストのとき' do
      before do
        get edit_plant_path plant
      end
      it 'HTTPのレスポンスが200 successとなる' do
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'PATCH #update' do
    context '有効なリクエストのとき' do
      before do
        patch "/plants/#{plant.id}", params: { plant: { name: 'edited' } }
        plant.reload
      end
      it 'フラッシュメッセージが存在する' do
        expect(flash.empty?).to_not be true
      end
      it '植物の名前が更新されている' do
        expect(plant.name).to eq 'edited'
      end
    end
  end

  describe 'DELETE #destroy' do
    context '有効なリクエストのとき' do
      before do
        delete "/plants/#{plant.id}"
      end
      it 'HTTPのレスポンスが302 successとなる' do
        expect(response).to have_http_status 302
      end
      it '植物一覧ページにリダイレクトされる' do
        expect(response).to redirect_to(plants_url)
      end
      it 'フラッシュメッセージが存在する' do
        expect(flash.empty?).to_not be true
      end
    end
  end
end

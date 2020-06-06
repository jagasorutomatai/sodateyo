require 'rails_helper'

RSpec.describe 'Plants', type: :request do
  include RequestSupport
  # let(:plant) { create :plant }
  let(:admin) { create :admin }
  before do
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
end

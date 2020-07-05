require 'rails_helper'

RSpec.describe "Ranks", type: :request do
    describe 'GET #index' do
        context '有効なリクエストのとき' do
            before do
                get ranks_path
            end
            it 'HTTPレスポンスステータスコードが 200 OK となる' do
                expect(response).to have_http_status 200
            end
        end
    end
end

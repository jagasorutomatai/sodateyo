require 'rails_helper'

RSpec.describe "Relationships", type: :request do
    include RequestSupport
    let!(:user) { create :user }
    let!(:other) { create(:other) }
    describe 'POST #create' do
        let!(:count) { Relationship.count }
        context 'ログインしているとき' do
            before do
                log_in_as user
            end
            context '有効なリクエストのとき' do
                before do
                  post relationships_path, params: { followed_id: other.id }, xhr: true
                end
                it 'HTTPレスポンスステータスコードが 200 ok となる' do
                  expect(response).to have_http_status 200
                end
                it 'DBに登録されている記事数が1つ増えてる' do
                    expect(Relationship.count).to eq (count + 1)
                end
            end
        end

        context 'ログインしていないとき' do
            before do
                post relationships_path, params: { followed_id: other.id }, xhr: true
            end
            it 'ログイン画面にリダイレクトされる' do
                expect(response).to redirect_to(login_url)
            end        
        end
    end
end

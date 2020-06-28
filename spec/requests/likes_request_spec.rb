require 'rails_helper'

RSpec.describe "Likes", type: :request do
    include RequestSupport
    let!(:user) { create :user }
    let!(:post1) { create(:post1, user:user) }
    describe 'POST #create' do
        let!(:count) { Like.count }
        context 'ログインしているとき' do
            before do
                log_in_as user
            end
            context '有効なリクエストのとき' do
                before do
                    post likes_path ,params: { post_id: post1.id }
                end
                it 'HTTPレスポンスステータスコードが 302 Found となる' do
                    expect(response).to have_http_status 302
                  end
                it 'DBに登録されているレコードが1つ増えてる' do
                    expect(Like.count).to eq (count + 1)
                end
            end
        end

        context 'ログインしていないとき' do
            before do
                post likes_path ,params: { post_id: post1.id }
            end
            it 'ログイン画面にリダイレクトされる' do
                expect(response).to redirect_to(login_url)
            end        
        end
    end

    describe 'DELETE #destroy' do
        let!(:like) { create(:like, user: user, post: post1) }
        let!(:count) { Like.count }
        context 'ログインしているとき' do
            before do
                log_in_as user
            end
            context '有効なリクエストのとき' do
                before do
                    delete "/likes/#{like.id}"
                end
                it 'HTTPレスポンスステータスコードが 200 ok となる' do
                    expect(response).to have_http_status 302
                  end
                it 'DBに登録されているレコードが1つ減っている' do
                    expect(Like.count).to eq (count - 1)
                end
            end
        end

        context 'ログインしていないとき' do
            before do
                delete "/likes/#{like.id}"
            end
            it 'ログイン画面にリダイレクトされる' do
                expect(response).to redirect_to(login_url)
            end        
        end
    end
end

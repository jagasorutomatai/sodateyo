require 'rails_helper'

RSpec.describe "Comments", type: :request do
    let!(:user) { create :user }
    let!(:post1) { create(:post1, user:user) }
    describe 'POST #create' do
        let!(:count) { Comment.count }
        context 'ログインしているとき' do
            before do
                log_in_as user
            end
            context '有効なリクエストのとき' do
                before do
                  post post_comments_path(post1), params: { comment: { content: 'コメント' }, post_id: post1.id }
                end
                it 'HTTPレスポンスステータスコードが 200 ok となる' do
                  expect(response).to have_http_status 302
                end
                it 'DBに登録されている記事数が1つ増えてる' do
                    expect(Comment.count).to eq (count + 1)
                end
            end

            context '無効なリクエストのとき' do
                before do
                  post post_comments_path(post1), params: { comment: { content: '' }, post_id: post1.id }
                end
                it 'DBに登録されている記事数が変わらない' do
                  expect(Comment.count).to_not eq (count + 1)
                end
            end 
        end
    end
end

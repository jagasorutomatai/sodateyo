"""
・Webリクエストが成功したか
・正しいページにリダイレクトされたか
・ユーザー認証が成功したか
・ビューに表示されたメッセージは適切か
"""

require 'rails_helper'

RSpec.describe "Posts", type: :request do
  include RequestSupport
  let!(:user) { create :user }
  let!(:prefecture) { create :prefecture }
  let!(:picture) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image.png')) }

  describe 'GET #index' do
    context 'ログインしているとき' do
      before do
        log_in_as user
      end
      context '有効なリクエストのとき' do
        before do
          get posts_path
        end
        it 'HTTPレスポンスステータスコードが 200 OK となる' do
          expect(response).to have_http_status 200
        end
      end
    end
  end

  describe "GET #new" do
    context 'ログインしているとき' do
      before do
        log_in_as user
      end
      context '有効なリクエストのとき' do
        before do
          get new_post_path
        end
        it 'HTTPレスポンスステータスコードが 200 OK となる' do
          expect(response).to have_http_status 200
        end
      end
    end
  end

  describe "POST #create" do
    let!(:count) { Post.count }
    context 'ログインしているとき' do
      before do
        log_in_as user
      end
      context '有効なリクエストのとき' do
        before do
          post posts_path, params: { post: { title: '記事のタイトル',
                                            content: '記事の内容',
                                            prefecture_id: prefecture.id,
                                            planted_at: '2020-06-23',
                                            picture: picture } }
        end
        it 'HTTPレスポンスステータスコードが 302 Found となる' do
          expect(response).to have_http_status 302
        end
        it 'DBに登録されている記事数が1つ増えてる' do
          expect(Post.count).to eq (count + 1)
        end
        it 'flashメッセージが表示される' do
          expect(flash[:success]).to eq '記事の登録に成功しました'
        end
      end
      context '無効なリクエストのとき' do
        before do
          post posts_path, params: { post: { title: '',
                                            content: '',
                                            prefecture_id: prefecture.id,
                                            planted_at: '2020-06-23',
                                            picture: picture } }
        end
        it 'DBに登録されている記事数が変わらない' do
          expect(Post.count).to_not eq (count + 1)
        end
      end
    end
  end

  describe 'GET #show' do
    let!(:post1) { create :post1 }
    context 'ログインしているとき' do
      before do
        log_in_as post1.user
      end
      context '有効なリクエストのとき' do
        before do
          get post_path(post1)
        end
        it 'HTTPレスポンスステータスコードが 200 OK となる' do
          expect(response).to have_http_status 200
        end
      end
    end
  end

  describe 'GET #edit' do
    let!(:post1) { create :post1 }
    context 'ログインしているとき' do
      before do
        log_in_as post1.user
      end 
      context '有効なリクエストのとき' do
        before do
          get edit_post_path(post1)
        end
        it 'HTTPレスポンスステータスコードが 200 OK となる' do
          expect(response).to have_http_status 200
        end
      end
    end
  end

  describe 'PATCH #update' do
    let!(:post1) { create :post1 }
    context 'ログインしているとき' do
      before do
        log_in_as post1.user
      end
      context '有効なリクエストのとき' do
        before do
          patch "/posts/#{post1.id}", params: { post: { title: '変更した記事のタイトル',
                                                       content: post1.content,
                                                       prefecture_id: post1.prefecture_id,
                                                       picture: picture } }
          post1.reload
        end
        it '記事の情報が更新されている' do
          expect(post1.title).to eq '変更した記事のタイトル'
        end
        it 'flashメッセージが表示される' do
          expect(flash[:success]).to eq '記事の情報を変更しました'
        end
      end
      context '無効なリクエストのとき' do
        before do
          patch "/posts/#{post1.id}", params: { post: { title: '',
                                                       content: '記事の内容',
                                                       prefecture_id: post1.prefecture_id,
                                                       picture: picture } }
          post1.reload
        end
        it '記事編集画面に戻る' do
          expect(request.fullpath).to eq post_path(post1)
        end
        it '記事の情報が更新されてない' do
          expect(post1.title).to_not eq ''
        end
      end 
    end
  end
end

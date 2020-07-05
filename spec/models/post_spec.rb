require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { create :user }
  let!(:prefecture) { create :prefecture }
  describe '存在性を検証する' do
    context 'all' do
      before do
        @post = Post.new(
          title: 'testplantname',
          content: 'testplantdescription',
          picture: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')),
          user_id: user.id,
          prefecture_id: prefecture.id,
          planted_at: '2020-06-23'
        )
      end
      it '有効である' do
        expect(@post).to be_valid
      end
    end

    context '投稿のタイトル(title)が空白のとき' do
      before do
        @post = build(:post1, user: user, prefecture: prefecture)
        @post.title = ''
      end
      it '無効である' do
        expect(@post).to_not be_valid
      end
    end

    context '投稿の内容(content)が空白のとき' do
      before do
        @post = build(:post1, user: user, prefecture: prefecture)
        @post.content = ''
      end
      it '無効である' do
        expect(@post).to_not be_valid
      end
    end

    context '写真(picture)が空白のとき' do
      before do
        @post = build(:post1, user: user, prefecture: prefecture)
        @post.picture = ''
      end
      it '無効である' do
        expect(@post).to_not be_valid
      end
    end

    context 'ユーザーID(user_id)が空白のとき' do
      before do
        @post = build(:post1, user: user, prefecture: prefecture)
        @post.user_id = ''
      end
      it '無効である' do
        expect(@post).to_not be_valid
      end
    end

    context '都道府県ID(prefecture_id)が空白のとき' do
      before do
        @post = build(:post1, user: user, prefecture: prefecture)
        @post.prefecture_id = ''
      end
      it '無効である' do
        expect(@post).to_not be_valid
      end
    end
  end

  describe '文字長を検証する' do
    context '投稿のタイトル(title)の文字長が61文字以上のとき' do
      before do
        @post = build(:post1, user: user, prefecture: prefecture)
        @post.title = 'a' * 61
      end
      it '無効である' do
        expect(@post).to_not be_valid
      end
    end

    context '投稿のタイトル(title)の文字長が60文字以下のとき' do
      before do
        @post = build(:post1, user: user, prefecture: prefecture)
        @post.title = 'a' * 60
      end
      it '有効である' do
        expect(@post).to be_valid
      end
    end

    context '投稿の内容(content)の文字長が141文字以上のとき' do
      before do
        @post = build(:post1, user: user, prefecture: prefecture)
        @post.content = 'a' * 141
      end
      it '無効である' do
        expect(@post).to_not be_valid
      end
    end

    context '投稿の内容(content)の文字長が140文字以下のとき' do
      before do
        @post = build(:post1, user: user, prefecture: prefecture)
        @post.content = 'a' * 140
      end
      it '有効である' do
        expect(@post).to be_valid
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create :user }
  let!(:post1) { create :post1 }
  describe '存在性を検証する' do
    context 'all' do
      before do
        @comment = Comment.new(
          content: 'コメント',
          user_id: user.id,
          post_id: post1.id,
        )
      end
      it '有効である' do
        expect(@comment).to be_valid
      end
    end

    context '投稿のタイトル(title)が空白のとき' do
      before do
        @comment = build(:comment, user: user, post: post1)
        @comment.content = ''
      end
      it '無効である' do
        expect(@comment).to_not be_valid
      end
    end
  end

  describe '文字長を検証する' do
    context '投稿のタイトル(title)の文字長が141文字以上のとき' do
      before do
        @comment = build(:comment, user: user, post: post1)
        @comment.content = 'a' * 141
      end
      it '無効である' do
        expect(@comment).to_not be_valid
      end
    end

    context '投稿のタイトル(title)の文字長が140文字以下のとき' do
      before do
        @comment = build(:comment, user: user, post: post1)
        @comment.content = 'a' * 140
      end
      it '無効である' do
        expect(@comment).to be_valid
      end
    end
  end
end

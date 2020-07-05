require 'rails_helper'

RSpec.describe Calendar, type: :model do
  let!(:post1) { create :post1 }
  describe '存在性を検証する' do
    context 'all' do
      before do
        @calendar = Calendar.new(
          month: "2020-01-01" ,
          content: "カレンダーの内容",
          temperature: 24,
          picture: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')),
          planted_flag: true,
          harvested_flag: false,
          post_id: post1.id
        )
      end
      it '有効である' do
        expect(@calendar).to be_valid
      end
    end

    context 'カレンダーの月(month)が空白のとき' do
      before do
        @calendar = build(:january, post: post1)
        @calendar.month = ''
      end
      it '無効である' do
        expect(@calendar).to_not be_valid
      end
    end
  end

  describe '文字長を検証する' do
    context '投稿のタイトル(title)の文字長が141文字以上のとき' do
      before do
        @calendar = build(:january, post: post1)
        @calendar.content = 'a' * 141
      end
      it '無効である' do
        expect(@calendar).to_not be_valid
      end
    end
    context '投稿のタイトル(title)の文字長が140文字以下のとき' do
      before do
        @calendar = build(:january, post: post1)
        @calendar.content = 'a' * 140
      end
      it '有効である' do
        expect(@calendar).to be_valid
      end
    end
  end
end

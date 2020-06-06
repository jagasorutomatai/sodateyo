require 'rails_helper'

RSpec.describe Plant, type: :model do
  let(:plant) { build :plant }
  describe '存在性を検証する' do
    context 'all' do
      before do
        plant = Plant.new(
          name: 'testplantname',
          description: 'testplantdescription',
          picture: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/image.png')),
          calendar_id: 1
        )
      end
      it '有効である' do
        expect(plant).to be_valid
      end
    end

    context '植物の名前(name)がないとき' do
      before do
        plant.name = ''
      end
      it '無効である' do
        expect(plant).to_not be_valid
      end
    end

    context '植物の説明(description)がないとき' do
      before do
        plant.description = ''
      end
      it '無効である' do
        expect(plant).to_not be_valid
      end
    end

    context '植物の写真(picture)がないとき' do
      before do
        plant.picture = ''
      end
      it '無効である' do
        expect(plant).to_not be_valid
      end
    end
  end

  describe '文字長を検証する' do
    context '植物の名前(name)の文字長が61文字以上のとき' do
      before do
        plant.name = 'a' * 61
      end
      it '無効である' do
        expect(plant).to_not be_valid
      end
    end

    context '植物の名前(name)の文字長が60文字以下のとき' do
      before do
        plant.name = 'a' * 60
      end
      it '有効である' do
        expect(plant).to be_valid
      end
    end

    context '植物の説明(description)の文字長が255文字以上のとき' do
      before do
        plant.description = 'a' * 255
      end
      it '無効である' do
        expect(plant).to_not be_valid
      end
    end

    context '植物の説明(description)の文字長が254文字以下のとき' do
      before do
        plant.description = 'a' * 254
      end
      it '有効である' do
        expect(plant).to be_valid
      end
    end
  end

  describe '一意性を検証する' do
    before do
      create(:plant, name: 'testplantname')
    end
    it '無効である' do
      duplicate_plant = build(:plant, name: plant.name)
      expect(duplicate_plant).to_not be_valid
    end
  end
end

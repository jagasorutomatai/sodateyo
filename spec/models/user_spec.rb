require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ FactoryBot.build (:user) }

  describe '存在性を検証する' do
    it '名前とメールアドレスがある場合、有効である' do
      user = User.new(
        name: 'testuser',
        email: 'testuser@sample.co.jp'
      )
      expect(user).to be_valid
    end

    it '名前(name)がない場合、無効である' do
      user.name = ''
      expect(user).to_not be_valid
    end

    it 'メールアドレス(email)がない場合、無効である' do
      user.email = ''
      expect(user).to_not be_valid
    end
  end

  describe '文字長を検証する' do
    it '名前(name)の文字長が61文字以上の場合、無効である' do
      user.name = 'a' * 61
      expect(user).to_not be_valid
    end

    it '名前(name)の文字長が60文字以下の場合、有効である' do
      user.name = 'a' * 60
      expect(user).to be_valid
    end

    it 'メールアドレス(email)の文字長が255文字以上の場合、無効である' do
      user.email = 'a' * 244 + '@sample.com'
      expect(user).to_not be_valid
    end

    it 'メールアドレス(email)の文字長が254文字以下の場合、有効である' do
      user.email = 'a' * 243 + '@sample.com'
      expect(user).to be_valid
    end
  end

  describe 'フォーマットを検証する' do
    # いつか修正する
    # /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
    it 'メールアドレス(email)が指定したフォーマットの場合、有効である' do
      valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it 'メールアドレス(email)が指定したフォーマットではない場合、無効である' do
      invalid_addresses = %w(user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com)
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to_not be_valid
      end
    end
  end
end
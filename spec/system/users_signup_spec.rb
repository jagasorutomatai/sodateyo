require 'rails_helper'

RSpec.describe User, type: :system do
    let(:user) { FactoryBot.build :user }
    describe 'サインアップ画面' do
        context '有効な値を入力した時' do
            before do
                visit signup_path
                fill_in 'user_name', with: 'testuser'
                fill_in 'user_email', with: 'testuser@sample.co.jp'
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on 'アカウント作成'
            end

            it 'フラッシュメッセージが表示される' do
                expect(page).to have_selector('.alert-success', text: 'アカウントの登録が完了しました')
            end
        end

        context '無効な値を入力した時' do
            before do
                visit signup_path
                fill_in 'user_name', with: ''
                fill_in 'user_email', with: ''
                fill_in 'user_password', with: ''
                fill_in 'user_password_confirmation', with: ''
                click_on 'アカウント作成'
            end

            it 'ユーザー作成画面が表示される' do
                expect(current_path).to eq signup_path
            end

            it 'フラッシュメッセージが表示される' do
                expect(page).to have_selector('.alert-danger', count: 6)
            end
        end
    end
end
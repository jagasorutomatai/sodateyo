require 'rails_helper'

RSpec.describe Plant, type: :system do
  include SystemSupport
  let(:other) { create :other }
  let(:admin) { create :admin }
  describe '植物の新規登録処理' do
    context 'ログインしていないとき' do
      before do
        visit new_plant_path
      end
      it 'ログイン画面に遷移する' do
        expect(current_path).to eq login_path
      end
    end

    context 'admin権限がないユーザーでログインしているとき' do
      before do
        log_in_as other
        visit new_plant_path
      end
      it 'ルートに遷移する' do
        expect(current_path).to eq root_path
      end
    end

    context 'admin権限があるユーザーでログインしているとき' do
      before do
        log_in_as admin
        visit new_plant_path
      end
      context '有効な値を入力したとき' do
        before do
          fill_in 'plant_name', with: 'testplantname'
          fill_in 'plant_description', with: 'testplantdescription'
          attach_file 'plant_picture', 'app/assets/images/logo.jpg'
          click_on '追加する'
        end
        it 'フラッシュメッセージが表示される' do
          expect(page).to have_selector('.alert-success', text: '植物の登録に成功しました')
        end
      end
    end
  end
end

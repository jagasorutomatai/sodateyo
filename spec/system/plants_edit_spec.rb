require 'rails_helper'

RSpec.describe Plant, type: :system do
  include SystemSupport
  let(:plant) { create :plant }
  let(:admin) { create :admin }
  before { plant }
  describe '植物の編集処理' do
    context 'admin権限があるユーザーでログインしているとき' do
      before do
        log_in_as admin
        visit plant_path(plant)
        click_on '編集する'
      end
      context '有効な値を入力したとき' do
        before do
          fill_in 'plant_name', with: 'edited'
          click_on '変更する'
        end
        it '植物詳細ページにリダイレクトされる' do
            expect(current_path).to eq plant_path(plant)
        end
        it 'フラッシュメッセージが表示される' do
          expect(page).to have_selector('.alert-success', text: '植物の情報を変更しました')
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Plant, type: :system do
  include SystemSupport
  let(:plant) { create :plant }
  let(:admin) { create :admin }
  before { plant }
  describe '植物の削除処理' do
    context 'admin権限があるユーザーでログインしているとき' do
      before do
        log_in_as admin
        visit plant_path(plant)
      end
      context '有効な値を入力したとき' do
        before do
          click_on '削除する'
          page.driver.browser.switch_to.alert.accept
        end
        it '植物一覧ページにリダイレクトされる' do
            expect(current_path).to eq plants_path
        end
        it 'フラッシュメッセージが表示される' do
          expect(page).to have_selector('.alert-success', text: '植物の情報を削除しました')
        end
      end
    end
  end
end

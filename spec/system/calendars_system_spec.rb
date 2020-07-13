require 'rails_helper'

RSpec.describe Calendar, type: :system do
  let!(:user) { create :user }
  let!(:kanagawa) { create :prefecture, name: '神奈川県'}
  describe 'カレンダー作成〜編集' do
    context 'カレンダーを作成したとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on 'マイページ'
            click_on '記事を投稿する'
            fill_in 'post_title', with: 'テスト記事のタイトル'
            fill_in 'post_content', with: 'テスト記事の内容'
            select '神奈川県', from: 'post_prefecture_id'
            fill_in 'planted_at', with: '2020/07/01'
            attach_file 'post_picture', 'spec/fixtures/image.png'
            click_on '追加する'
        end
        it 'カレンダーが1月分ある' do
            expect(page).to have_selector('.calendar_card', count: 1)
        end
        it 'カレンダーの最初の月が栽培開始日である' do
            expect(first('.calendar_card')).to have_content '2020年7月'
        end
        it 'カレンダーの最初の月に種植えと表示される' do
            expect(first('.calendar_card')).to have_selector '.badge', text: '栽培開始'
        end
    end

    context 'カレンダーを編集したとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on 'マイページ'
            click_on '記事を投稿する'
            fill_in 'post_title', with: 'テスト記事のタイトル'
            fill_in 'post_content', with: 'テスト記事の内容'
            select '神奈川県', from: 'post_prefecture_id'
            fill_in 'planted_at', with: '2020/07/01'
            attach_file 'post_picture', 'spec/fixtures/image.png'
            click_on '追加する'
            first('.calendar_card').click_on 'カレンダー編集'
            fill_in 'calendar_content', with: 'テスト'
            select '26', from: 'calendar_temperature'
            click_on '登録する'
        end
        it '気温が反映されている' do
            expect(page).to have_selector '.badge', text: '気温:26℃'
        end
    end

    context 'カレンダーを編集したとき' do
        before do
            visit login_path
            fill_in 'session_email', with: 'testuser@sample.com'
            fill_in 'session_password', with: 'password'
            check 'ログイン情報を記憶する'
            click_on 'ログインする'
            click_on 'マイページ'
            click_on '記事を投稿する'
            fill_in 'post_title', with: 'テスト記事のタイトル'
            fill_in 'post_content', with: 'テスト記事の内容'
            select '神奈川県', from: 'post_prefecture_id'
            fill_in 'planted_at', with: '2020/07/01'
            attach_file 'post_picture', 'spec/fixtures/image.png'
            click_on '追加する'
            first('.calendar_card').click_on 'カレンダー編集'
            fill_in 'calendar_content', with: 'a'*141
            select '25', from: 'calendar_temperature'
            click_on '登録する'
        end
        it 'エラーメッセージが表示される' do
            expect(page).to have_selector('.alert-danger', text: 'カレンダーの内容は140文字以内で入力してください')
        end
    end
  end
end
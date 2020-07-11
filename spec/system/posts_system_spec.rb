# ユーザー作成〜編集〜削除までの総合テスト

require 'rails_helper'

RSpec.describe Post, type: :system do
  let!(:user) { create :user }
  let!(:kanagawa) { create :prefecture, name: '神奈川県'}
  let!(:tokyo) { create :prefecture, name: '東京都'}
  describe '記事作成〜編集処理' do
    context 'ユーザー作成フォームで正常な値を入力したとき' do
      before do
        visit login_path
        fill_in 'session_email', with: 'testuser@sample.com'
        fill_in 'session_password', with: 'password'
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
      it 'フラッシュメッセージが表示される' do
        expect(page).to have_selector('.alert-success', text: '記事の登録に成功しました')
      end
      it '記事のタイトルが表示される' do
        expect(page).to have_content 'テスト記事のタイトル'
      end
      it '記事の内容が表示される' do
        expect(page).to have_content 'テスト記事の内容'
      end
      it '都道府県が表示される' do
        expect(page).to have_content '神奈川県'
      end
      it '記事を投稿したユーザーの名前が表示される' do
        expect(page).to have_content 'testuser'
      end
    end

    context 'ユーザー作成フォームで異常な値を入力したとき' do
      before do
        visit login_path
        fill_in 'session_email', with: 'testuser@sample.com'
        fill_in 'session_password', with: 'password'
        click_on 'ログインする'
        click_on 'マイページ'
        click_on '記事を投稿する'
        fill_in 'post_title', with: ''
        fill_in 'post_content', with: ''
        fill_in 'planted_at', with: ''
        click_on '追加する'
      end
      it 'エラーメッセージが表示される' do
          expect(page).to have_selector('.alert-danger', text: '記事のタイトルを入力してください')
      end
      it 'エラーメッセージが表示される' do
          expect(page).to have_selector('.alert-danger', text: '記事の内容を入力してください')
      end
      it 'エラーメッセージが表示される' do
          expect(page).to have_selector('.alert-danger', text: '植物の画像を選択してください')
      end
      it 'エラーメッセージが表示される' do
          expect(page).to have_selector('.alert-danger', text: '栽培開始日を選択してください')
      end
    end

    context 'ユーザー編集フォームで正常な値を入力したとき' do
      before do
        visit login_path
        fill_in 'session_email', with: 'testuser@sample.com'
        fill_in 'session_password', with: 'password'
        click_on 'ログインする'
        click_on 'マイページ'
        click_on '記事を投稿する'
        fill_in 'post_title', with: 'テスト記事のタイトル'
        fill_in 'post_content', with: 'テスト記事の内容'
        select '神奈川県', from: 'post_prefecture_id'
        fill_in 'planted_at', with: '2020/07/01'
        attach_file 'post_picture', 'spec/fixtures/image.png'
        click_on '追加する'
        click_on '編集'
        fill_in 'post_title', with: '変更したテスト記事のタイトル'
        fill_in 'post_content', with: '変更したテスト記事の内容'
        select '東京都', from: 'post_prefecture_id'
        attach_file 'post_picture', 'spec/fixtures/image.png'
        click_on '変更する'

      end
      it 'フラッシュメッセージが表示される' do
        expect(page).to have_selector('.alert-success', text: '記事の情報を変更しました')
      end
      it '記事のタイトルが変更されてる' do
        expect(page).to have_content '変更したテスト記事のタイトル'
      end
      it '記事の内容が変更されてる' do
        expect(page).to have_content '変更したテスト記事の内容'
      end
      it '都道府県が変更されてる' do
        expect(page).to have_content '東京都'
      end
    end

    context 'ユーザー編集フォームで異常な値を入力したとき' do
      before do
        visit login_path
        fill_in 'session_email', with: 'testuser@sample.com'
        fill_in 'session_password', with: 'password'
        click_on 'ログインする'
        click_on 'マイページ'
        click_on '記事を投稿する'
        fill_in 'post_title', with: 'テスト記事のタイトル'
        fill_in 'post_content', with: 'テスト記事の内容'
        select '神奈川県', from: 'post_prefecture_id'
        fill_in 'planted_at', with: '2020/07/01'
        attach_file 'post_picture', 'spec/fixtures/image.png'
        click_on '追加する'
        click_on '編集'
        fill_in 'post_title', with: ''
        fill_in 'post_content', with: ''
        click_on '変更する'

      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: '記事のタイトルを入力してください')
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_selector('.alert-danger', text: '記事の内容を入力してください')
      end
    end
  end

  describe '記事検索' do
    context '5件分の記事一覧がDBに登録されているとき' do
      let!(:posts) { create_list(:posts, 5, user:user, prefecture:kanagawa) }
      before do
        visit login_path
        fill_in 'session_email', with: 'testuser@sample.com'
        fill_in 'session_password', with: 'password'
        click_on 'ログインする'
        click_on '投稿を検索'
      end
      it '1ページ分の記事数を表示される' do
        expect(page).to have_selector('.post_card', count: 5)
      end
      it 'ページネーションが表示されない' do
        expect(page).to_not have_selector '.pagination'
      end
    end

    context '10件分の記事一覧がDBに登録されているとき' do
      let!(:posts) { create_list(:posts, 10, user:user, prefecture:kanagawa) }
      before do
        visit login_path
        fill_in 'session_email', with: 'testuser@sample.com'
        fill_in 'session_password', with: 'password'
        click_on 'ログインする'
        click_on '投稿を検索'
      end
      it '1ページ分の記事数を表示される' do
        expect(page).to have_selector('.post_card', count: 5)
      end
      it 'ページネーションが表示される' do
        expect(page).to have_selector '.pagination'
      end
    end

    context '記事一覧ページで検索をしたとき' do
      let!(:posts_kanagawa) { create_list(:posts, 5, user:user, prefecture:kanagawa) }
      let!(:posts_tokyo) { create_list(:posts, 5, user:user, prefecture:tokyo) }
      context '記事のタイトルで検索したとき' do
        before do
          visit login_path
          fill_in 'session_email', with: 'testuser@sample.com'
          fill_in 'session_password', with: 'password'
          click_on 'ログインする'
          click_on '投稿を検索'
          fill_in 'q_title_or_content_or_user_name_cont', with: posts_kanagawa[1]['title']
          click_on '検索'
        end
        it '検索条件に該当する記事のタイトルが表示される' do
          expect(page).to have_content posts_kanagawa[1]['title']
        end
        it '検索条件に該当する記事の内容が表示される' do
          expect(page).to have_content posts_kanagawa[1]['content']
        end
      end

      context '記事の内容で検索したとき' do
        before do
          visit login_path
          fill_in 'session_email', with: 'testuser@sample.com'
          fill_in 'session_password', with: 'password'
          click_on 'ログインする'
          click_on '投稿を検索'
          fill_in 'q_title_or_content_or_user_name_cont', with: posts_kanagawa[1]['content']
          click_on '検索'
        end
        it '検索条件に該当する記事のタイトルが表示される' do
          expect(page).to have_content posts_kanagawa[1]['title']
        end
        it '検索条件に該当する記事の内容が表示される' do
          expect(page).to have_content posts_kanagawa[1]['content']
        end
      end

      context '都道府県で検索したとき' do
        before do
          visit login_path
          fill_in 'session_email', with: 'testuser@sample.com'
          fill_in 'session_password', with: 'password'
          click_on 'ログインする'
          click_on '投稿を検索'
          select kanagawa['name'], from: 'q_prefecture_name_cont'
          click_on '検索'
        end
        it '記事が5件表示される' do
          expect(page).to have_selector('.post_card', count: 5)
        end
        it '検索結果に東京都が含まれてない' do
          expect(page).to_not have_content "栽培地:#{tokyo['name']}"
        end
      end

      context '都道府県+記事のタイトルで検索したとき' do
        before do
          visit login_path
          fill_in 'session_email', with: 'testuser@sample.com'
          fill_in 'session_password', with: 'password'
          click_on 'ログインする'
          click_on '投稿を検索'
          fill_in 'q_title_or_content_or_user_name_cont', with: posts_kanagawa[1]['title']
          select kanagawa['name'], from: 'q_prefecture_name_cont'
          click_on '検索'
        end
        it '検索条件に該当する記事のタイトルが表示される' do
          expect(page).to have_content posts_kanagawa[1]['title']
        end
        it '検索条件に該当する記事の内容が表示される' do
          expect(page).to have_content posts_kanagawa[1]['content']
        end
      end
    end
  end
end

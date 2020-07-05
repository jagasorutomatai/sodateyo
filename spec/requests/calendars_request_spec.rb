require 'rails_helper'

RSpec.describe "Calendars", type: :request do
    include RequestSupport
    let!(:user) { create :user }
    let!(:post1) { create(:post1, user:user) }
    let!(:other) { create :other }
    describe 'GET #edit' do
        let!(:january) { create(:january, post: post1) }
        context 'ログインしているとき' do
          before do
            log_in_as user
          end
          context '有効なリクエストのとき' do
            before do
              get "/calendars/#{january.id}/edit", xhr: true
            end
            it 'HTTPレスポンスステータスコードが 200 OK となる' do
              expect(response).to have_http_status 200
            end
          end
        end
    
        context 'ログインしてないとき' do
          before do
            get "/calendars/#{january.id}/edit", xhr: true
          end
          it 'ログイン画面にリダイレクトされる' do
            expect(response).to redirect_to(login_url)
          end
        end
    
        context '別のアカウントでログインしているとき' do
          before do
            log_in_as other
            get "/calendars/#{january.id}/edit", xhr: true
          end
          it 'ログイン画面にリダイレクトされる' do
            expect(response).to redirect_to(root_url)
          end
        end
    end

    describe 'PATCH #update' do
        let!(:january) { create(:january, post: post1) }
        context 'ログインしているとき' do
            before do
              log_in_as user
            end
            context '有効なリクエストのとき' do
                before do
                    patch "/calendars/#{january.id}", params: { calendar: { content: '変更したカレンダーの内容',
                                                                            temperature: january.temperature,
                                                                            picture: january.picture } }
                    january.reload
                end
                it 'カレンダーの内容が更新されている' do
                    expect(january.content).to eq '変更したカレンダーの内容'
                end
            end
        end

        context 'ログインしてないとき' do
            before do
                patch "/calendars/#{january.id}", params: { calendar: { content: '変更したカレンダーの内容',
                                                                        temperature: january.temperature,
                                                                        picture: january.picture } }
                january.reload
            end
            it 'ログイン画面にリダイレクトされる' do
              expect(response).to redirect_to(login_url)
            end
        end

        context '別のアカウントでログインしているとき' do
            before do
                log_in_as other
                patch "/calendars/#{january.id}", params: { calendar: { content: '変更したカレンダーの内容',
                                                                        temperature: january.temperature,
                                                                        picture: january.picture } }
                january.reload
            end
            it 'ログイン画面にリダイレクトされる' do
              expect(response).to redirect_to(root_url)
            end
        end
    end
end

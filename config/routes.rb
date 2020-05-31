Rails.application.routes.draw do
  # 静的ページ
  root 'static_pages#home'
  get  '/help', to: 'static_pages#help'
  get  '/about', to: 'static_pages#about'
  # ユーザーページ
  resources :users
end

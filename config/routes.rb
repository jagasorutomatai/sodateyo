Rails.application.routes.draw do
  get 'users/new'
  # サイト全体のホームと概要紹介ページ
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
end

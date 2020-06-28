Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/new'
  get 'posts/show'
  get 'posts/edit'
  get 'sessions/new'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :plants
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :calendars, only: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :ranks, only: [:index]
end

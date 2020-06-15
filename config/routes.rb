Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/new'
  get 'posts/show'
  get 'posts/edit'
  get 'sessions/new'
  root 'static_pages#home'
  get  '/help', to: 'static_pages#help'
  get  '/about', to: 'static_pages#about'
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
  resources :calendars
  resources :relationships, only: [:create, :destroy]
end

Rails.application.routes.draw do
  root 'sessions#new'
  get 'invite', to: 'invitations#new'
  post 'invite', to: 'invitations#create'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  resources :users, only: [:show, :index]
  resources :events, except: [:edit, :update, :destroy]
end

Rails.application.routes.draw do
  root 'welcome#index'
  get '/login', to: 'sessions#new', as: 'login'
  get '/auth/github/callback', to: 'sessions#create'
  get '/signup', to: 'users#new', as: 'signup'
  delete '/logout', to: 'sessions#destroy'
  resources :sessions, only: [:create]
  resources :users, except: [:new]
  resources :teams
end

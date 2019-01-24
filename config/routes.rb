Rails.application.routes.draw do
  root 'welcome#index'
  get '/login', to: 'sessions#new'
  get '/signup', to: 'users#new'
  delete '/logout', to: 'sessions#destroy'
  resources :sessions, only: [:create]
  resources :users, except: [:new]
end

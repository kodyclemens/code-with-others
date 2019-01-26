Rails.application.routes.draw do
  root 'welcome#index'
  get '/login', to: 'sessions#new', as: 'login'
  get '/auth/github/callback', to: 'sessions#create'
  get '/signup', to: 'users#new', as: 'signup'
  get '/users/:id/technologies', to: 'user_technologies#new', as: 'user_technologies'
  post '/users/:id/technologies', to: 'user_technologies#create'
  delete '/users/:id/technologies', to: 'user_technologies#destroy'


  delete '/logout', to: 'sessions#destroy'
  resources :sessions, only: [:create]
  resources :users, except: [:new]
  resources :teams do
    resources :comments
  end
end

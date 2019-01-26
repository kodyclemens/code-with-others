Rails.application.routes.draw do
  root 'welcome#index'
  get '/login', to: 'sessions#new', as: 'login'
  get '/auth/github/callback', to: 'sessions#create'
  get '/signup', to: 'users#new', as: 'signup'
  delete '/logout', to: 'sessions#destroy'

  get '/users/:id/technologies/new', to: 'user_technologies#new', as: 'user_technologies'
  post '/users/:id/technologies/new', to: 'user_technologies#create'
  delete '/users/:id/technologies', to: 'user_technologies#destroy', as: 'user_technology'

  get '/teams/:id/technologies/new', to: 'team_technologies#new', as: 'team_technologies'
  post '/teams/:id/technologies/new', to: 'team_technologies#create'
  delete '/teams/:id/technologies', to: 'team_technologies#destroy', as: 'team_technology'

  resources :sessions, only: [:create]
  resources :users, except: [:new]

  resources :teams do
    resources :comments
  end
end

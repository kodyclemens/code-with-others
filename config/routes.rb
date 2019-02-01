Rails.application.routes.draw do
  root 'welcome#index'
  get '/login', to: 'sessions#new', as: 'login'
  get '/auth/github/callback', to: 'sessions#omniauth'
  get '/signup', to: 'users#new', as: 'signup'
  delete '/logout', to: 'sessions#destroy'
  get '/teams/most_comments', to: 'teams#most_comments', as: 'most_comments'

  get '/users/:id/technologies/new', to: 'user_technologies#new', as: 'user_technologies'
  post '/users/:id/technologies/new', to: 'user_technologies#create'
  delete '/users/:id/technologies', to: 'user_technologies#destroy', as: 'user_technology'
  # post and delete do not need to be nested
  # be sure all nested routes make sense

  get '/teams/:id/technologies/new', to: 'team_technologies#new', as: 'team_technologies'
  post '/teams/:id/technologies/new', to: 'team_technologies#create'
  delete '/teams/:id/technologies', to: 'team_technologies#destroy', as: 'team_technology'

  resources :sessions, only: [:create]

  resources :users, except: [:new] do
    resources :user_teams, only: [:create, :destroy], as: 'team'
  end

  # filter to only what I use
  resources :teams do
    resources :comments
  end
end

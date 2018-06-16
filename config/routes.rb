Rails.application.routes.draw do
  # devise
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'registrations'
  }

  # vote comments
  resources :vote_comments

  # vote publications
  post 'votes', to: 'votes#add_vote'

  # moderators
  post 'moderate/request', to: 'requests#apply'
  patch 'moderate/request/:id', to: 'requests#accept'
  delete 'moderate/request/:id', to: 'requests#reject'
  get 'moderate/request', to: 'requests#show', as: 'requests'
  delete 'moderate', to: 'requests#resign'

  # resources
  resources :publications
  resources :comments
  resources :subscriptions
  resources :favorites
  resources :forums

  # users
  resources :users
  post '/upload/:id', to: 'users#upload'

  # forums
  get '/forums/:id/new_publication', to: 'forums#new_publication', as: 'new_forum_publication'

  # search
  get '/home/search/forums', to: 'home#search_forum', as: 'search_forum'
  get '/home/search/publications', to: 'home#search_publication', as: 'search_publication'
  get '/home/search/users', to: 'home#search_user', as: 'search_user'

  # home and root
  get 'welcome/index'
  root 'welcome#index'
  get '/home', to: 'home#index', as: :home

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

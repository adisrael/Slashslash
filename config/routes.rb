Rails.application.routes.draw do
  post 'vote_comment/create', as: 'vote_comments'
  post 'vote/create', as: 'votes'
  post 'moderate/apply', to: 'forums#moderate_apply'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'registrations'
  }
  resources :publications
  resources :comments
  resources :subscriptions
  resources :forums
  get '/forums/:id/new_publication', to: 'forums#new_publication', as: 'new_forum_publication'
  get '/home/search/forums', to: 'home#search_forum', as: 'search_forum'
  get '/home/search/publications', to: 'home#search_publication', as: 'search_publication'
  resources :users
  get 'welcome/index'
  root 'welcome#index'
  # get '/users/:id', :to => 'users#show', :as => :user

  get '/home', to: 'home#index', as: :home

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

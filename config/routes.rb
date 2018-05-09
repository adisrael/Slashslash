Rails.application.routes.draw do
  get 'vote_comment/create'

  post 'vote/create', as: 'votes'

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'registrations'
      }
  resources :publications
  resources :comments
  resources :subscriptions
  resources :forums
  get '/forums/:id/new_publication', to: 'forums#new_publication', as: 'new_forum_publication'
  resources :users
  get 'welcome/index'
  root 'welcome#index'
  #get '/users/:id', :to => 'users#show', :as => :user

  get '/home', to: 'home#index', as: :home

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

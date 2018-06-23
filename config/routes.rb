Rails.application.routes.draw do
  # devise
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
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

  # polls
  post 'poll', to: 'publications#poll_vote', as: 'poll_vote'

  # users
  resources :users
  post '/upload/:id', to: 'users#upload'

  # forums
  get '/forums/:id/new_publication/text', to: 'forums#new_publication', as: 'new_publication_text'
  get '/forums/:id/new_publication/link', to: 'forums#new_publication_link', as: 'new_publication_link'
  get '/forums/:id/new_publication/image', to: 'forums#new_publication_image', as: 'new_publication_image'
  post '/forums/:id/new_publication/image', to: 'forums#image_upload', as: 'image_upload'
  get '/forums/:id/new_publication/poll', to: 'forums#new_publication_poll', as: 'new_publication_poll'
  post '/forums/:id/new_publication/poll', to: 'forums#create_poll', as: 'create_poll'
  get '/forums/:id/new_publication/link', to: 'forums#new_publication_link', as: 'new_publication_link'
  post '/forums/:id/new_publication/link', to: 'forums#create_link', as: 'create_link'

  # search
  get '/home/search/forums', to: 'home#search_forum', as: 'search_forum'
  get '/home/search/publications', to: 'home#search_publication', as: 'search_publication'
  get '/home/search/users', to: 'home#search_user', as: 'search_user'

  #  top
  get '/home/top_forums', to: 'home#top_forums', as: 'top_forums'
  get '/home/top/publications', to: 'home#top_publications', as: 'top_publications'
  get '/home/top/users', to: 'home#top_users', as: 'top_users'
  get '/home/top/subscribed', to: 'home#top_subscribed', as: 'top_subscribed'

  # home and root
  get 'welcome/index'
  root 'welcome#index'
  get '/home', to: 'home#index', as: :home

  # dashboard
  get '/stats', to: 'statistics#index', as: '/stats'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  resources :publications
  resources :comments
  resources :subscriptions
  resources :forums
  #resources :users
  get 'welcome/index'
  root 'welcome#index'

  get '/home', to: 'home#index', as: :home

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

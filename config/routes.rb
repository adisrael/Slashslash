Rails.application.routes.draw do
  resources :publications
  resources :comments
  resources :subscriptions
  resources :forums
  resources :users
  get 'welcome/index'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

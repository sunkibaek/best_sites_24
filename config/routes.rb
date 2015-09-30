Rails.application.routes.draw do
  root 'homes#show'

  get '/tags/:tag', to: 'homes#show'

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  resources :sites, only: [:show, :new, :create]

  get 'tags/:tag', to: 'sites#index', as: :tags
  get 'login', to: 'sessions#new'

  namespace :admin do
  end
end

Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  root 'sites#index'

  resources :sites, only: [:index, :show, :new, :create]

  get 'tags/:tag', to: 'sites#index', as: :tags
  get 'login', to: 'sessions#new'

  namespace :admin do
  end
end

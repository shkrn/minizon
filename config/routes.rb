Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "top#index"

  resources :users
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update, :new, :create]
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "top#index"

  resources :users
  resources :items do
    get :search, on: :collection
  end
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update, :new, :create]
  resource :password, only: [:show, :edit, :update]
  resource :cart
  resources :cart_items
end

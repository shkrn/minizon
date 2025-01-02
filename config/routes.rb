Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "top#index"

  resources :users do
    resources :reviews, only: [:index, :destroy, :edit, :update]
    resources :favorite_items, only: [:index]
    resources :favorite_users, only: [:index, :create, :destroy]
    collection do
      get 'favorites' # これを追加
    end
  end

  resources :items do
    get :search, on: :collection
    resources :reviews, only: [:index, :new, :create, :destroy, :edit, :update] do
      patch :report, on: :member
    end
    resources :favorite_items, only: [:create, :destroy]
  end
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update, :new, :create]
  resource :password, only: [:show, :edit, :update]
  resource :cart
  resources :cart_items
  resources :orders
  resources :order_items

  post "order/confirm" => "orders#confirm"

  
end

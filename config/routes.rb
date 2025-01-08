Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "top#index"
  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"

  resources :users,only: [:index,:show,:favorites] do
    resources :reviews, only: [:index, :destroy, :edit, :update]
    resources :favorite_items, only: [:index]
    resources :favorite_users, only: [:index, :create, :destroy]
    collection do
      get 'favorites' # これを追加
    end
    resources :items do
      get :search, on: :collection
    end
  end

  resources :items, only: [:index, :show] do
    get :search, on: :collection
    resources :reviews, only: [:index, :new, :create, :destroy, :edit, :update] do
      patch :report, on: :member
    end
    resources :favorite_items, only: [:create, :destroy]
  end
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update, :new, :create, :destroy]
  resource :password, only: [:show, :edit, :update]
  resource :cart
  resources :cart_items
  resources :orders
  resources :order_items do
    patch :return, on: :member
  end

  get "login" => "top#login"
  post "login" => "sessions#create"

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :index, :show, :destroy]

  namespace :seller do
    root "top#index"
    resources :items do
      get :search, on: :collection
    end
    resources :orders
    resources :order_items
    resources :users
  end

  namespace :admin do
    root "top#index"
    get "login" => "top#login"
    post "login" => "sessions#create"
    delete 'logout' => 'sessions#destroy'
    resource :session, only: [:create, :destroy]
    resources :orders
    resources :order_items
    resources :items do
      get :search, on: :collection
    end
    resources :users do
      resources :reviews, only: [:index, :destroy]
      get :search, on: :collection
      resources :items do
        get :search, on: :collection
      end
    end
    resources :items do
      get :search, on: :collection
    end
    resources :categories
    resources :reviews  do
      get :search, on: :collection
    end
    resources :admins do
      get :search, on: :collection
    end
  end

  post "order/confirm" => "orders#confirm"

  
end

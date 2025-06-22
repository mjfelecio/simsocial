Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :users do
    resources :posts
    get "/", to: "users#index"
    get "/profile", to: "users#profile", as: :profile
    get "/profile/new", to: "users#new_profile", as: :new_profile
    get "/profile/edit", to: "users#edit_profile", as: :edit_profile
    patch "/profile", to: "users#update_profile", as: :update_profile
  end

  # In routes.rb
  resources :users, only: %i[ index show ] do
    member do
      post :follow
      delete :unfollow
    end
  end

  resources :posts do
    resources :comments
    resources :likes, only: [ :create ]
  end

  resources :comments do
    resources :likes, only: [ :create ]
  end
end

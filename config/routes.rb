Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :users do
    resources :posts
    get "/", to: "users#index"
    get "/profile", to: "users#profile"
    get "/profile/new", to: "users#new_profile"
    get "/profile/edit", to: "users#edit_profile"
    patch "/profile", to: "users#update_profile"
  end

  resources :posts do
    resources :likes, only: [ :create, :destroy ]
  end
end

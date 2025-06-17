Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :users do
    resources :posts
    get "/", to: "users#index", as: :users
    get "/profile", to: "users#profile", as: :user_profile
    get "/profile/new", to: "users#new_profile", as: :new_user_profile
    get "/profile/edit", to: "users#edit_profile", as: :edit_user_profile
    patch "/profile", to: "users#update_profile", as: :update_profile
  end
end

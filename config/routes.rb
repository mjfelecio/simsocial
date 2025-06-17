Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :users do
    resources :posts
  end

  get "/users", to: "users#index", as: :users
  get "/users/:id/profile", to: "users#profile", as: :user_profile
  get "/users/:id/profile/new", to: "users#new_profile", as: :new_user_profile
  get "/users/:id/profile/edit", to: "users#edit_profile", as: :edit_user_profile
  patch "/users/:id/profile", to: "users#update_profile", as: :update_profile
end

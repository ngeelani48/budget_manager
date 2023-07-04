Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :transactions
  resources :groups
  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"

  get "/home", to: "home#index"
end

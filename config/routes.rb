Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}

  resources :tasks

  get '/search/:q', to: "tasks#search", as: 'search'
  get '/search', to: "tasks#index"
  get '/show_del', to: "tasks#show_del"

  root to: "tasks#index"
end

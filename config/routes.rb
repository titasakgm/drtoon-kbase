Rails.application.routes.draw do
  resources :tasks

  get '/search/:q', to: "tasks#search", as: 'search'
  get '/search', to: "tasks#index"
  get '/show_del', to: "tasks#show_del"

  root to: "tasks#index"
end

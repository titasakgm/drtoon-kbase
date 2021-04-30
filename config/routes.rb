Rails.application.routes.draw do
  resources :tasks

  get '/search/:q', to: "tasks#search"
  root to: "tasks#index"
end

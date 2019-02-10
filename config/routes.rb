Rails.application.routes.draw do
  devise_for :users
  resources :houses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'houses#index'
  get '/houses/:id' => 'houses#show', as: 'show'
  get '/button/:id', to: 'houses#button', as: 'button'
  post '/houses/:id', to: 'houses#favourite', as: 'favourite'
  get 'users/:id' => 'houses#favourite_list', as: 'favouritelist'
end
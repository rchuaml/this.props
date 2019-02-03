Rails.application.routes.draw do
  devise_for :users
  resources :houses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'houses#index'
  get '/houses/:id' => 'houses#show'

end
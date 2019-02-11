Rails.application.routes.draw do
  devise_for :users
  resources :houses

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'houses#index'
  get '/houses/:id' => 'houses#show', as: 'show'
  
  get '/messages/new/:house_id' => 'messages#new', as:'new_message'

  post '/messages/create/:sellerbuyer_id' => 'messages#create', as: 'create_message'

  post '/messages/createfirst/:house_id' => 'messages#createfirst', as: 'createfirst_message'
  get '/messages' => 'messages#index', as: 'messages'
  get '/messages/:sellerbuyer_id' => 'messages#show', as: 'message'

  get '/button/:id', to: 'houses#button', as: 'button'
  post '/houses/:id', to: 'houses#favourite', as: 'favourite'
  get 'users/:id' => 'houses#favourite_list', as: 'favouritelist'
  
end
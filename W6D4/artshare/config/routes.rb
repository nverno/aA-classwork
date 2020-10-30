Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/users', to: 'users#index', as: 'users'
  # get '/users/:id', to: 'users#show', as: 'user'
  # post '/users', to: 'users#create', as: 'create_user'
  # patch '/users/:id', to: 'users#update', as: 'update_user'
  # delete '/users/:id', to: 'users#destroy', as: 'destroy_user'
  # get '/users/new', to: 'users#new', as: 'new_user'
  # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  resources :users, only: [:index, :show, :create, :update, :destroy] 
  resources :users do 
      # /users/:user_id/artworks
      resources :artworks, only: [:index]
  end
  # get '/usesr/:user_id/artworks' to: 'artworks#index'
  resources :artworks, only: [:index, :show, :create, :update, :destroy]  
  resources :artwork_shares, only: [:index, :show, :create, :update, :destroy]  
end

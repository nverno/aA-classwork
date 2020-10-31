Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/users', to: 'users#index', as: 'users'
  # get '/users/:id', to: 'users#show', as: 'user'
  # post '/users', to: 'users#create', as: 'create_user'
  # patch '/users/:id', to: 'users#update', as: 'update_user'
  # delete '/users/:id', to: 'users#destroy', as: 'destroy_user'
  # get '/users/new', to: 'users#new', as: 'new_user'
  # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  resources :users, only: %i[index show create update destroy]
  resources :users do
    # /users/:user_id/artworks
    resources :artworks, only: [:index]
  end
  # get '/usesr/:user_id/artworks' to: 'artworks#index'
  resources :artwork_shares, only: %i[index show create update destroy]
  resources :artworks, only: %i[index show create update destroy] do
    member do
      post :like, to: 'artworks#like', as: 'like'
      post :unlike, to: 'artworks#unlike', as: 'unlike'
    end
  end

  resources :comments, only: %i[index create destroy] do
    member do
      post :like, to: 'comments#like', as: 'like'
      post :unlike, to: 'comments#unlike', as: 'unlike'
    end
  end
  resources :likes, only: %i[index]
end

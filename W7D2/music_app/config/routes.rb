Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'
  resources :users
  resource :session, only: %i[new create destroy]

  resources :bands do
    resources :albums, only: :new
  end
  resources :albums, only: %i[create edit destroy show index update] do
    resources :tracks, only: :new
  end

  resources :tracks, only: %i[create edit show index update destroy]
end

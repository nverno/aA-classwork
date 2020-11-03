Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: %i[new create] do
    member do
      post :approve
      post :deny
    end
  end

  root to: redirect('/cats')
  resources :users
  resource :session, only: %i[show new create destroy]

  resource :session, only: :delete do
    post :delete_many, to: 'sessions#destroy_sessions', as: 'destroy_many'
  end
end

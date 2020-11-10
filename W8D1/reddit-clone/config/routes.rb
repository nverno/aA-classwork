Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'subs#index'
  resources :users
  resource :session, only: %i[create destroy new]
  resources :subs

  resources :posts do
    resources :comments, only: :new
  end

  resources :comments, only: %i[create show]
end

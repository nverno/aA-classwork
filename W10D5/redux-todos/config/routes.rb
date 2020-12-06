Rails.application.routes.draw do
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]

  namespace :api, defaults: { format: :json } do
    resources :todos, except: %i[edit new] do
      resources :steps, only: %i[index create]
    end

    resources :steps, only: %i[update destroy]
  end

  root to: 'static_pages#root'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'subs#index'
  resources :users
  resource :session, only: %i[create destroy new]
  resources :subs do
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  resources :posts do
    resources :comments, only: :new
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  resources :comments, only: %i[create show] do
    member do
      post 'upvote'
      post 'downvote'
    end
  end
end

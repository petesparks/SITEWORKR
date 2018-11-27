Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  mount ActionCable.server => '/cable'

  root to: 'pages#home'

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    collection do
      get 'search', to: "users#search"
    end
  end
  resources :matches do
    collection do
      post "hire", to: "matches#hire"
      post "accept", to: "matches#accept"
    end
    resources :messages
    resources :reviews, only: [ :new, :create ]
  end
  resources :jobs do
      collection do
      get 'search', to: "jobs#search"
      post "finish", to: "matches#finish"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

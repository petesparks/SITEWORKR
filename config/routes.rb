Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: 'pages#home'

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    collection do
      get 'search', to: "users#search"
    end
  end
  resources :matches do
    resources :messages
    resources :reviews, only: [ :new, :create ]
  end
  resources :jobs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

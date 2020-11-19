Rails.application.routes.draw do
  devise_for :users
  get 'profile', to: 'users#show'

  root to: 'pages#home'

  resources :listings do
    resources :bookings, except: [:index, :destroy]
  end

  resources :bookings, only: [:index, :destroy]
end

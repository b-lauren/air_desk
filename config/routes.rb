Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :listings do
    resources :bookings, except: [:new, :index, :destroy]
  end

  resources :bookings, only: [:index, :destroy]
end

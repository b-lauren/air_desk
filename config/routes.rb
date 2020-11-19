Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :listings do
    resources :bookings, except: [:index, :destroy]
  end

  get 'bookings', to: 'bookings#index'
  delete 'bookings/:id', to: 'bookings#destroy'
end

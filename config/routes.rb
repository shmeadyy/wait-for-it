WaitForIt::Application.routes.draw do
  root :to => 'guests#index'
  resources :restaurants, only: [:new, :create, :index] do
    resources :reservations, only: [:update, :destroy, :index, :create, :show]
  end
  resources :sessions, only:[:create, :destroy]
  resources :messages, only: [:create]
  resources :guests, only: [:index]

  get '/guest/:restaurant_name', to: 'reservations#guest', as: :guest_waitlist
  get '/reservations/currentreservations', to: 'reservations#currentreservations', constraints: {format: /json/}

end

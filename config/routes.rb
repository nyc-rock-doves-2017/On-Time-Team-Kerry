Rails.application.routes.draw do
  root 'sessions#home'

  resources :contractors, only: [:show]
  resources :merchants do
    resources :orders, only: [:index, :new, :create, :update, :show]
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'sessions#newsignup'
  post '/signup' => 'sessions#createsignup'
  get '/registration' => 'sessions#newregistration'
  post '/registration' => 'sessions#createregistration'

  get '/open_orders' => 'orders#index'
  get '/merchants/:id/full_merchant_history' => 'merchants#full'

end

Rails.application.routes.draw do
  root 'sessions#home'

  resources :merchants, :contractors, only: [:show]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'sessions#newsignup'
  post '/signup' => 'sessions#createsignup'
  get '/registration' => 'sessions#newregistration'
  post '/registration' => 'sessions#createregistration'
end

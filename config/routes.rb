Rails.application.routes.draw do

  resources :merchants, only: [:new, :create, :show]

end

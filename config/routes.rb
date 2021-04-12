Rails.application.routes.draw do
  root 'venues#index'
  post 'venue', to: 'venues#create'
  delete 'venue', to: 'venues#destroy'
  post 'reservation', to: 'reservations#create'
  post 'signup', to: 'users#new'
  delete 'users', to: 'users#destroy'
  get 'users', to: 'users#index'
  put 'users', to: 'users#update'
end

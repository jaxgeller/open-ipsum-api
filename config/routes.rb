Rails.application.routes.draw do
  root to: 'meta#index'

  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'

  post '/signin', to: 'sessions#create'
  delte '/signout', to: 'sessions#destroy'

  resources :ipsums, except: [:new, :edit]
end

Rails.application.routes.draw do
  resources :ipsums, except: [:new, :edit]
  get '/search', to: 'ipsums#search'

  post '/users', to: 'users#create'
  get '/users/:id', to: 'users#show'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'

  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  post '/passwords', to: 'password_resets#create'
  post '/passwords/:id/update', to: 'password_resets#update'

  get '/*404', to: 'application#route_not_found'
end

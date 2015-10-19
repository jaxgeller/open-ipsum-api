Rails.application.routes.draw do

  post '/users', to: 'users#create'
  get '/users/:id', to: 'users#show'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'

  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :ipsums, except: [:new, :edit]
  get '/search', to: 'ipsums#search'
end

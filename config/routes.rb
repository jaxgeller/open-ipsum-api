Rails.application.routes.draw do

  resources :ipsums, except: [:new, :edit]
end

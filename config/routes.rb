Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles

  post '/login', to: 'tokens#create'
  delete '/login', to: 'tokens#destroy'
end

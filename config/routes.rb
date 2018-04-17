Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles do
    resources :comments, only: [:index, :create]
  end

  post '/login', to: 'tokens#create'
  delete '/login', to: 'tokens#destroy'
end

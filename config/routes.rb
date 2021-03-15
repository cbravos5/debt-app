Rails.application.routes.draw do
  resources :debts
  resources :users, only: [:new, :create]
  root 'sessions#welcome'

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'welcome', to: 'sessions#welcome'

  delete '/logout', to: 'sessions#logout'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

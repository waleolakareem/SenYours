Rails.application.routes.draw do
  resources :sessions
  resources :users do
    resources :appointments, shallow: true
    resources :reviews,shallow: true
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login' => 'sessions#new'

  post  '/login' => 'sessions#create'

  get '/logout', to: 'sessions#destroy'
  root 'users#new'
end

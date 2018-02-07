Rails.application.routes.draw do
  get 'welcome/index'
  resources :charges
  resources :sessions
  resources :users do
    resources :appointments, shallow: true
    resources :reviews,shallow: true
    resources :available_days, shallow: true do
      resources :available_times, shallow: true
    end
    resources :conversations, shallow: true do
     resources :messages
  end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/be_a_comp' => 'welcome#be_a_comp'

  get '/need_a_comp' => 'welcome#need_a_comp'

  get '/privacy_policy' => 'welcome#privacy_policy'

  get '/terms_of_services' => 'welcome#terms_of_services'

  get 'cookie_policy' => 'welcome#cookie_policy'

  get '/comp_request' => 'appointments#comp_request'

  get '/login' => 'sessions#new'

  post  '/login' => 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  root 'welcome#index'
end

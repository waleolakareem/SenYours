Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  resources :blog

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'welcome/index'
  mount ActionCable.server => '/cable'
  resources :charges
  resources :sessions
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
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
  get 'cities/:state', to: 'application#cities'

  get '/assesment' => 'users#assesment'

  get '/be_a_comp' => 'welcome#be_a_comp'

  get '/need_a_comp' => 'welcome#need_a_comp'

  get '/sen_new' => 'users#sen_new'

  get '/comp_new' => 'users#comp_new'

  get '/comp_test' => 'users#comp_test'

  get '/privacy_policy' => 'welcome#privacy_policy'

  get '/terms_of_services' => 'welcome#terms_of_services'

  get '/cookie_policy' => 'welcome#cookie_policy'

  get '/payment_policy' => 'welcome#payment_policy'

  get '/comp_request' => 'appointments#comp_request'

  get '/login' => 'sessions#new'

  post  '/login' => 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  root 'welcome#index'

end

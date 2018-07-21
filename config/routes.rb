Rails.application.routes.draw do


  post 'stripe_webhook' => 'transactions#stripe_webhook'
  get 'slack_webhook' => 'transactions#slack_webhook'
  get 'verify' => 'transactions#verify'
  resources :transactions

  resources :tasks do
    get 'add_selected' => 'tasks#add_selected'
    get 'remove_selected' => 'tasks#remove_selected'
  end

  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => '/cable'
  resources :blog
  get '/password_input' => 'blog#password_input'
  post '/password_authenticate' => 'blog#password_authenticate'
  get '/end_session' => 'blog#end_session'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'welcome/index'
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

  get '/companion' => 'welcome#be_a_comp'

  get '/super_adult' => 'welcome#need_a_comp'

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

  get '/about' => 'welcome#team'

  root 'welcome#index'

end

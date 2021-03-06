Rails.application.routes.draw do

  # Public site
  root to: 'home#index'
  get 'about_us' => 'home#about_us', as: 'about_us'
  get 'pricing' => 'home#pricing', as: 'pricing'
  get 'consumers' => 'home#consumers', as: 'consumers'
  get 'privacy_policy' => 'home#privacy_policy', as: 'privacy_policy'
  get 'terms_of_service' => 'home#terms_of_service', as: 'terms_of_service'
  resources :contacts, only: %i[new create update]
  get 'contacts/thank_you' => 'contacts#thank_you', as: :thank_you

  # Users Setup
  devise_for :users,
    :controllers => {
      registrations: 'users/registrations',
      sessions:      'users/sessions'
    }

  namespace :users do
    get '/dashboard', to: 'dashboard#index', as: 'dashboard', controller: 'users/dashboard'
    resources :charges
    resources :apps
    resources :devices
    resources :administrators
    resources :settings
    resources :reports
    scope 'mfa' do
      get '/authenticate/new', to: 'mfa_authentications#new', as: 'authenticate', controller: 'users/mfa_authentications'
    end
    scope 'mfa' do
      get '/register/new', to: 'mfa_registrations#new', as: 'register', controller: 'users/mfa_registrations'
    end
  end

end

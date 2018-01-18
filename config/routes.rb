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

  # restrict routes access outside sub-domain scope
  constraints Subdomain do
    namespace :users do
      get '/dashboard', to: 'dashboard#index', as: 'dashboard', controller: 'users/dashboard'
      resources :charges
      resources :apps
      resources :devices
      resources :administrators
      resources :settings
      resources :reports
    end
  end

end

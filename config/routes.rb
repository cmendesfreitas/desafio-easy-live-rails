Rails.application.routes.draw do
  apipie
  root to: 'apipie/apipies#index'

  namespace :myadminpanel do
    resources :admins
    resources :users
    resources :products
    resources :stores

    root to: 'products#index'
  end
  devise_for :admins, skip: [:registrations]

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/overrides/registrations',
        sessions: 'api/v1/overrides/sessions',
        token_validations: 'api/v1/overrides/token_validations',
        passwords: 'api/v1/overrides/passwords'
      }
      resources :products, only: %i[index show]
      resources :carts, only: %i[index create destroy]
    end
  end
end

Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :products, only: %i[index show]
    end
  end
end

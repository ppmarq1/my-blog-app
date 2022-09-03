# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  # Defines the root path route ("/")
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root 'users#index'

  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[index show] do
        resources :posts, only: %i[index show] do
          resources :comments, only: %i[index create]
        end
      end
    end
  end

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show destroy] do
    end
  end

  resources :posts, only: %i[new create update destroy] do
    resources :comments
    resources :likes
  end
end

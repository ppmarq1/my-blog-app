Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show] do
    end
  end

  resources :posts do
    resources :comments, only: %i[new create]
    resources :likes, only: %i[create]
  end
end

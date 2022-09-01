Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show destroy] do
    end
  end

  resources :posts, only: [:new, :create, :update, :destroy] do
    resources :comments
    resources :likes
  end
end

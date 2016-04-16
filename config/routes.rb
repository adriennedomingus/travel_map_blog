Rails.application.routes.draw do
  root to: 'users#show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  namespace :user do
    resources :blogs, only: [:new, :create]
  end

  get 'users/:id/blogs', to: 'user/blogs#index', as: 'users_blogs'

  resources :blogs, only: [:show]
end

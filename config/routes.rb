Rails.application.routes.draw do
  root to: 'users#show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  get 'users/:id/blogs', to: 'user/blogs#index', as: 'users_blogs'
  get 'users/:id/blogs/:slug', to: 'user/blogs#edit', as: 'edit_user_blog'

  get 'users/:id/trips', to: 'trips#index', as: 'users_trips'
  # patch 'users/:id/trips/:slug', to: 'user/trips#edit', as: 'edit_user_trip'
  get 'users/:id/trips/:slug', to: 'trips#show', as: 'users_trip'

  resources :blogs, only: [:show], param: :slug
  resources :trips, only: [:new, :create]
  resources :trips, only: [:show], param: :slug

  namespace :user do
    resources :blogs, only: [:new, :create, :update, :destroy]
  end
end

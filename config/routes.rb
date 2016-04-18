Rails.application.routes.draw do
  root to: 'users#show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  get 'users/:nickname', to: 'users#show'
  get 'users/:nickname/blogs', to: 'user/blogs#index', as: 'users_blogs'
  get 'users/:nickname/blogs/:slug', to: 'user/blogs#edit', as: 'edit_user_blog'

  get 'users/:nickname/trips', to: 'trips#index', as: 'users_trips'
  get 'users/:nickname/trips/:slug', to: 'trips#show', as: 'users_trip'
  get '/blog-markers', to: 'blogs#index'

  resources :blogs, only: [:show], param: :slug
  resources :trips, only: [:new, :create, :update, :destroy]
  resources :trips, only: [:show, :edit], param: :slug

  namespace :user do
    resources :blogs, only: [:new, :create, :update, :destroy]
  end
end

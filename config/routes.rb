Rails.application.routes.draw do
  root to: 'users#show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  namespace :user do
    resources :blogs, only: [:new, :create, :update, :destroy]
  end

  get 'users/:id/blogs', to: 'user/blogs#index', as: 'users_blogs'
  get 'users/:id/blogs/:slug', to: 'user/blogs#edit', as: 'edit_user_blog'

  resources :blogs, only: [:show], param: :slug
end

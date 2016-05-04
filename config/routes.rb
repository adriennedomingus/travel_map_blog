Rails.application.routes.draw do
  root                               to: 'welcome#show'
  get 'auth/:provider/callback',     to: 'sessions#create',     as: :login
  get '/logout',                     to: 'sessions#destroy',    as: :logout

  get 'users/:nickname',             to: 'users#show',          as: 'user'
  get 'users/:nickname/blogs',       to: 'user/blogs#index',    as: 'users_blogs'
  get 'users/:nickname/blogs/:slug', to: 'user/blogs#edit',     as: 'edit_user_blog'

  get 'users/:nickname/photos',      to: 'user/photos#index',   as: 'user_photos'

  get 'users/:nickname/trips',       to: 'trips#index',         as: 'users_trips'
  get 'users/:nickname/trips/:slug', to: 'trips#show',          as: 'users_trip'

  get '/blog-markers/:nickname',     to: 'blogs#index'
  get '/photo-markers/:nickname',    to: 'photos#index'
  get '/blog-image/:slug',           to: 'blogs#weather'
  get '/trip-colors/:nickname',      to: 'trips#color'

  get '/blogs/search',               to: 'blogs/search#new',    as: 'new_blog_search'
  post '/blogs/search',              to: 'blogs/search#index',  as: 'blog_search_index'
  post '/blogs/:id/comments',        to: 'blogs/comments#create', as: 'blog_comments'

  get '/photos/search',               to: 'photos/search#new',    as: 'new_photo_search'
  post '/photos/search',              to: 'photos/search#index',  as: 'photo_search_index'
  get 'user/:nickname/photos/:slug',  to: 'user/photos#show',          as: 'user_photo'

  resources :blogs,                  only: [:show],             param: :slug
  resources :trips,                  only: [:new, :create, :update, :destroy]
  resources :trips,                  only: [:show, :edit],      param: :slug
  resources :photos,                 except: [:index, :show]

  namespace :user do
    resources :blogs,                only: [:new, :create, :update, :destroy]
  end
end

Rails.application.routes.draw do


  get 'categories/export', to: 'categories#export', defaults: { format: :csv }
  get 'categories/import', to: 'categories#import'
  post 'categories/import', to: 'categories#import_file'
  get 'posts/export', to: 'posts#export'
  get 'posts/import', to: 'posts#import'
  post 'posts/import', to: 'posts#import_file'

  get 'login', to: 'users#login'
  post 'login', to: 'users#action_login'
  get 'users/:id/password', to: 'users#edit_password', as: 'change_password_form'
  patch 'users/:id/password', to: 'users#update_password', as: 'change_password'
  delete 'logout', to: 'users#logout'

  get 'password_reset_url', to: 'users#password_reset_url'
  post 'password_reset_url', to: 'users#password_reset_url_action'

  get 'users/password/:id/:token', to: 'users#password_reset', as: 'reset_password'
  patch 'users/password/:id', to: 'users#password_reset_action', as: 'reset_password_action'


  resources :users
  resources :categories
  resources :posts

  get 'categories/search', to: 'categories#search', as: 'categories_search'
  

  root 'posts#index'
end

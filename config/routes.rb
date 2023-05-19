Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/new'
  # get 'users/create'
  # get 'users/edit'
  # get 'users/destroy'
  
  # get 'categories/index'
  # post 'categories/create'
  # get 'categories/new'
  # get 'categories/delete'
  # get 'categories/update'
  # get 'categories/show'
  # get 'categories/new'

  get 'categories/export', to: 'categories#export',  defaults: { format: :csv }
  get 'categories/import', to: 'categories#import'
  post 'categories/import', to: 'categories#import_file'
  get 'posts/export', to: 'posts#export'
  get 'posts/import', to: 'posts#import'
  post 'posts/import', to: 'posts#import_file'

  get 'login', to: "users#login"
  post 'login', to: "users#action_login"
  get 'users/:id/password', to: "users#edit_password"
  patch 'users/:id/password', to: "users#update_password", as: "change_password"
  delete 'logout', to: "users#logout"  
  resources :users
  resources :categories
  resources :posts

  get 'categories/search', to: "categories#search", as: "categories_search"
  # post 'posts/:id', to: "posts#update"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end

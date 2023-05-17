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

  get 'login', to: "users#login"
  post 'login', to: "users#action_login"
  delete 'logout', to: "users#logout"
  resources :users
  resources :categories
  resources :posts
  # post 'posts/:id', to: "posts#update"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end

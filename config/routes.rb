Rails.application.routes.draw do
  get "users/index" => "users#index"
  get "users/new" => "users#new"
  get "users/:id/edit" => "users#edit"
  get "users/:id" => "users#show"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  post "users/:id/update" => "users#update"



  get "posts/index" => "posts#index"
  get "posts/:id" => "posts#show"
  get "posts/new" => "posts#new"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  post "posts/create" => "posts#create"
  
  get "/" => "home#top"
  get "about" => "home#about"
end

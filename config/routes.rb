Rails.application.routes.draw do

  get 'likes/:post_id/create' => 'likes#create'
  get 'likes/:post_id/destroy' => 'likes#destroy'

  post 'logout' => 'users#logout'
  get 'login_form' => 'users#login_form'
  post 'login' => 'users#login'

  get 'users/index' => 'users#index'
  get 'users/new' => 'users#new'
  post 'users/create'=> 'users#create'
  get 'users/:id' => 'users#show'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'
  post 'users/:id/destroy' => 'users#destroy'

  get '/posts/index' => 'posts#index'
  post 'posts/create'=> 'posts#create'
  get 'posts/:id' => 'posts#show'
  get 'posts/:id/destroy' => 'posts#destroy'

  get '/' => 'home#top'


end

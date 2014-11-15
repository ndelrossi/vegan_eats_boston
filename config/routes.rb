VeganEatsBoston::Application.routes.draw do

  root 'static_pages#home'

  resources :users, except: :destroy
  resources :posts
  resources :places
  resources :reviews
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

  controller :sessions do
    get    'signin'  => :new
    delete 'signout' => :destroy
  end

  controller :static_pages do
    get 'blog'  => :blog
    get 'about' => :about
    get 'admin' => :admin
  end

  namespace :admin do
    get 'dashboard' => 'dashboards#index' 
    resources :users, only: :destroy
    controller :posts do
      patch 'approve/:id'   => :approve,     as: 'approve_post'  
      patch 'unapprove/:id' => :unapprove,   as: 'unapprove_post'
    end
  end

  get 'signup'             => 'users#new'
  get 'users/activate/:id' => 'users#activate',     as: 'users_activate'

  get "/404" => "errors#not_found"
  get "/422" => "errors#unacceptable"
  get "/500" => "errors#internal_error"
end

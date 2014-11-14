VeganEatsBoston::Application.routes.draw do

  root 'static_pages#home'

  resources :users
  resources :posts do
    member do
      patch 'approve'
      patch 'unapprove'
    end
  end
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
    resources :users, only: [:index, :destroy]
  end

  get 'signup'             => 'users#new'
  get 'users/activate/:id' => 'users#activate',     as: 'users_activate'

  get "/404" => "errors#not_found"
  get "/422" => "errors#unacceptable"
  get "/500" => "errors#internal_error"
end

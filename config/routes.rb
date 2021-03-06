VeganEatsBoston::Application.routes.draw do

  root 'static_pages#home'

  resources :users, except: [:index, :destroy]
  resources :posts, except: :index
  resources :places, only: [:index, :show]
  resources :reviews, except: :index
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

  namespace :admin do
    get 'dashboard' => 'dashboards#index' 
    resources :users, only: :destroy
    resources :places, except: [:index, :show]
    controller :posts do
      patch 'posts/approve/:id'   => :approve,     as: 'approve_post'  
      patch 'posts/unapprove/:id' => :unapprove,   as: 'unapprove_post'
    end
  end

  controller :sessions do
    get    'signin'  => :new
    delete 'signout' => :destroy
  end

  controller :static_pages do
    get 'about' => :about
  end

  get 'signup'             => 'users#new'
  get 'users/activate/:id' => 'users#activate',     as: 'users_activate'

  get "/404" => "errors#not_found"
  get "/422" => "errors#unacceptable"
  get "/500" => "errors#internal_error"
end

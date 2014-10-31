VeganEatsBoston::Application.routes.draw do

  root  'static_pages#home'

  resources :users
  resources :posts do
    member do
      put 'approve'
      put 'unapprove'
    end
  end
  resources :places
  resources :reviews
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

  get 'signup'             => 'users#new'
  get 'signin'             => 'sessions#new'
  delete 'signout'         => 'sessions#destroy'
  get 'blog'               => 'static_pages#blog'
  get 'about'              => 'static_pages#about'
  get 'admin'              => 'static_pages#admin'
  get 'users/activate/:id' => 'users#activate',     as: 'users_activate'

  get "/404" => "errors#not_found"
  get "/422" => "errors#unacceptable"
  get "/500" => "errors#internal_error"
end

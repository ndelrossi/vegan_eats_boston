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

  match '/signup',            to: 'users#new',            via: 'get'
  match '/signin',            to: 'sessions#new',         via: 'get'
  match '/signout',           to: 'sessions#destroy',     via: 'delete'
  match '/blog',              to: 'static_pages#blog',    via: 'get'
  match '/about',             to: 'static_pages#about',   via: 'get'
  match '/admin',             to: 'static_pages#admin',   via: 'get'
  match '/posts_index_admin', to: 'posts#index_admin',    via: 'get'
  match '/users/activate/:id',to: 'users#activate',       via: 'get',     as: 'users_activate'

  get "/404", to: "errors#not_found"
  get "/422", to: "errors#unacceptable"
  get "/500", to: "errors#internal_error"
end

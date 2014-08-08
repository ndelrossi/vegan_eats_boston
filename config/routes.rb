VeganEatsBoston::Application.routes.draw do

  resources :users
  resources :posts
  resources :places
  resources :comments, only: [:create, :index, :destroy]
  resources :reviews
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets
  root  'static_pages#home'
  match '/signup',            to: 'users#new',            via: 'get'
  match '/signin',            to: 'sessions#new',         via: 'get'
  match '/signout',           to: 'sessions#destroy',     via: 'delete'
  match '/blog',              to: 'static_pages#blog',    via: 'get'
  match '/about',             to: 'static_pages#about',   via: 'get'
  match '/admin',             to: 'static_pages#admin',   via: 'get'
  match '/posts_index_admin', to: 'posts#index_admin',    via: 'get'
  match '/posts/approve',     to: 'posts#approve',        via: 'post'
  match '/posts/unapprove',   to: 'posts#unapprove',      via: 'post'

  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

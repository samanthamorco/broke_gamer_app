Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'

  # resources :reviews
  # resources :deals
  resources :products
  resources :wishes

  namespace :api do
    namespace :v1 do
      resources :reviews
      resources :wishes
      resources :deals
    end
  end
  
  get '/index', to: "pages#index"
  post '/products/search', to:'products#search'


  get '/reviews/new', to: 'reviews#new'
  post '/reviews/:id', to: 'reviews#create'

  get '/deals/', to: 'deals#index'
  get '/deals/new', to: 'deals#new' 
  get '/deals/pending', to: 'deals#show'
  get '/deals/:id/edit', to: 'deals#edit'
  post '/products/:id', to: 'deals#create'
  patch '/deals/pending', to: 'deals#update'

  # delete '/wishlist/:id', to: 'wishlists#destroy'

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

Sg::Application.routes.draw do
  get "pedidos_compra/index"
  #get "pedidos_compra/show/:id"
  get "pedidos_compra/update"
  get 'pedido_compra/:id/show' => 'pedidos_compra#show', as: :pedido_compra_show
  resources :componentes

  resources :marcas

  resources :componentes_categorias

  resources :configuraciones

  resources :localidades, only: [:index] do
    collection do
      post 'crear'
      post 'buscar_ciudades'
    end

    member do
      post 'editar'
      patch 'actualizar'
      delete 'eliminar'
      post 'get_estados'
      post 'get_paises'
      post 'get_ciudades'
    end
  end

  #post 'localidades/get_estados/:id', to: 'localidades#get_estados', as: 'get_estados_localidades'

  resources :products
  resources :providers do
    collection do
      post 'load_test_data'
    end
  end

  devise_for :users
  get "pages/index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'

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

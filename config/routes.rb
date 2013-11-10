Sg::Application.routes.draw do

  resources :ordenes_devolucion
  resources :ordenes_compra do
    collection do
      post 'get_pedido_compra'
      post 'orden_personalizado'
      get 'imprimir_listado'
      get 'update_list'
    end
  end

  resources :pedidos_cotizacion do
    member do
      get 'imprimir_pedido'
    end

    collection do
      post 'get_pedido_compra'
      post 'cotizar'
      get 'imprimir_listado'
    end
  end

  resources :facturas_compra do
    collection do
      post 'get_orden_compra'
      get 'check_numero'
      get 'imprimir_listado'
    end
    member do
      get 'imprimir_factura'
    end
  end

  resources :proveedores do
    collection do
      post 'load_test_data'
      get 'nueva_ciudad'
      get 'nueva_categoria'
      get 'imprimir_todos'
    end
  end
  resources :pedidos_compra do
    collection do
      get 'create_test_data'
      get 'imprimir_listado'
    end
    member do
      get 'create_pedido_cotizacion'
    end
  end

  resources :componentes do

    collection do
      get 'nueva_marca'
      get 'nueva_categoria'
    end
  end

  resources :marcas

  resources :componentes_categoria

  resources :configuraciones

  resources :localidades, only: [:index] do
    collection do
      post 'crear'
      get  'nueva_ciudad'
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

  resources :facturacion_configuraciones, only: [:index] do
    collection do
      post 'crear'
      get 'nuevo'
    end

    member do
      get 'editar'
      patch 'actualizar'
      delete 'eliminar'
    end
  end

  #post 'localidades/get_estados/:id', to: 'localidades#get_estados', as: 'get_estados_localidades'

  resources :productos

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

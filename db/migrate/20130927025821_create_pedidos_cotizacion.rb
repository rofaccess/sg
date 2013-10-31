class CreatePedidosCotizacion < ActiveRecord::Migration
  def change
    create_table :pedidos_cotizacion do |t|
      t.string   :numero           ,default: '' ,limit: Domain::NUMERO_DOC_COM ,null: false
      t.string   :estado           ,default: '' ,limit: Domain::ESTADO ,null: false
      t.datetime :fecha_generado   ,null: false
      t.datetime :fecha_cotizado
      t.datetime :fecha_procesado
      t.integer  :user_id          ,null: false
      t.decimal  :total_requerido  ,default: 0
      t.decimal  :total_cotizado   ,default: 0
      t.integer  :pedido_compra_id ,null: false
      t.integer  :proveedor_id     ,null: false

      t.timestamps
    end

    add_index :pedidos_cotizacion, :numero, unique: true
    add_foreign_key(:pedidos_cotizacion, :personas, column: 'proveedor_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:pedidos_cotizacion, :pedidos_compra, column: 'pedido_compra_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:pedidos_cotizacion, :users, column: 'user_id', options: 'ON DELETE RESTRICT')
  end
end

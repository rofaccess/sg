class CreateOrdenesCompra < ActiveRecord::Migration
  def change
    create_table :ordenes_compra do |t|
      t.string   :numero              ,default: '' ,limit: Domain::NUMERO_DOC_COM ,null: false
      t.string   :estado              ,default: '' ,limit: Domain::ESTADO         ,null: false
      t.datetime :fecha_generado      ,null: false
      t.datetime :fecha_procesado
      t.decimal  :total_requerido     ,default: 0
      t.decimal  :total_recibido      ,default: 0
      t.integer :user_id              ,null: false
      t.integer :proveedor_id         ,null: false
      t.integer :pedido_cotizacion_id ,null: false
      t.integer :pedido_compra_id     ,null: false

      t.timestamps
    end

    add_index :ordenes_compra, :numero, unique: true
    add_foreign_key(:ordenes_compra, :users, column: 'user_id', name: 'orden_compra_usuario_foreign_key', options: 'ON DELETE RESTRICT')
    add_foreign_key(:ordenes_compra, :personas, column: 'proveedor_id', name: 'orden_compra_proveedor_foreign_key', options: 'ON DELETE RESTRICT')
    add_foreign_key(:ordenes_compra, :pedidos_cotizacion, column: 'pedido_cotizacion_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:ordenes_compra, :pedidos_compra, column: 'pedido_compra_id', options: 'ON DELETE RESTRICT')
  end
end

class CreatePedidoCotizacions < ActiveRecord::Migration
  def change
    create_table :pedidos_cotizacion do |t|
      t.string :numero
      t.integer :proveedor_id
      t.string :estado
      t.datetime :fecha_creacion
      t.datetime :fecha_cotizado
      t.integer :user_id
      t.integer :pedido_compra_id

      t.timestamps
    end

    add_foreign_key(:pedidos_cotizacion, :personas, column: 'proveedor_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:pedidos_cotizacion, :pedidos_compra, column: 'pedido_compra_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:pedidos_cotizacion, :users, column: 'user_id', options: 'ON DELETE RESTRICT')
  end
end

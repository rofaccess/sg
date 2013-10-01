class AddForeignKeyToOrdenesCompras < ActiveRecord::Migration
  def change
  	add_foreign_key(:ordenes_compras, :users, column: 'user_id', name: 'orden_compra_usuario_foreign_key', options: 'ON DELETE RESTRICT')
  	add_foreign_key(:ordenes_compras, :personas, column: 'proveedor_id', name: 'orden_compra_proveedor_foreign_key', options: 'ON DELETE RESTRICT')
  	add_foreign_key(:ordenes_compras, :pedidos_cotizacion, column: 'pedido_cotizacion_id', options: 'ON DELETE RESTRICT')
  end
end

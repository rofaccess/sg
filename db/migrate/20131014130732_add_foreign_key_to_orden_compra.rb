class AddForeignKeyToOrdenCompra < ActiveRecord::Migration
  def change
  	  add_foreign_key(:ordenes_compras, :pedidos_compra, column: 'pedido_compra_id', options: 'ON DELETE RESTRICT')

  end
end

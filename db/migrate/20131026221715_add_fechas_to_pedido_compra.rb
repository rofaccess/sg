class AddFechasToPedidoCompra < ActiveRecord::Migration
  def change
  	remove_column :pedidos_compra, :fecha
  	add_column :pedidos_compra, :fecha_generado, :datetime
  	add_column :pedidos_compra, :fecha_procesado, :datetime
  	add_column :pedidos_compra, :fecha_ordenado, :datetime
  end
end

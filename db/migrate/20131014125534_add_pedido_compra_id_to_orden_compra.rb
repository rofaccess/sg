class AddPedidoCompraIdToOrdenCompra < ActiveRecord::Migration
  def change
  	add_column :ordenes_compras, :pedido_compra_id, :integer
  end
end

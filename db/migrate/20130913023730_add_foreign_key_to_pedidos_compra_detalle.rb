class AddForeignKeyToPedidosCompraDetalle < ActiveRecord::Migration
  def change
  	add_foreign_key(:pedidos_compra_detalle, :pedidos_compra, dependent: :delete, column: 'pedido_compra_id', name: 'pedido_compra_detalle_pedido_foreign_key')
  	add_foreign_key(:pedidos_compra_detalle, :componentes, column: 'componente_id', name: 'pedido_compra_detalle_componente_foreign_key', options: 'ON DELETE RESTRICT')
  end
end

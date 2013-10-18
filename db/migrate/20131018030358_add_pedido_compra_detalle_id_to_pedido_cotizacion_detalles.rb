class AddPedidoCompraDetalleIdToPedidoCotizacionDetalles < ActiveRecord::Migration
  def change
  	add_column :pedidos_cotizacion_detalle, :pedido_compra_detalle_id, :integer
  	add_foreign_key(:pedidos_cotizacion_detalle, :pedidos_compra_detalle, column: 'pedido_compra_detalle_id', options: 'ON DELETE CASCADE')
  end
end

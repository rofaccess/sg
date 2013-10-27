class AddOrdenCompraDetalleIdToFacturaCompraDetalleId < ActiveRecord::Migration
  def change
  	add_column :facturas_compra_detalle, :orden_compra_detalle_id, :integer
  	add_foreign_key(:facturas_compra_detalle, :ordenes_compra_detalle, column: 'orden_compra_detalle_id', options: 'ON DELETE RESTRICT')
  end
end

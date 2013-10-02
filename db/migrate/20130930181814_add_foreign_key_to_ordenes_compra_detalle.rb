class AddForeignKeyToOrdenesCompraDetalle < ActiveRecord::Migration
  def change
  	add_foreign_key(:ordenes_compra_detalle, :ordenes_compras, dependent: :delete, column: 'orden_compra_id', name: 'orden_compra_detalle_orden_foreign_key')
  	add_foreign_key(:ordenes_compra_detalle, :componentes, column: 'componente_id', name: 'orden_compra_detalle_componente_foreign_key', options: 'ON DELETE RESTRICT')
  end
end

class AddForeignKeyToFacturasCompra < ActiveRecord::Migration
  def change
  	add_foreign_key(:facturas_compra, :ordenes_compras, column: 'orden_compra_id', options: 'ON DELETE RESTRICT')
  end
end

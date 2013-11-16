class AddDeletedAtToTables < ActiveRecord::Migration
  def change
    add_column :facturas_compra, :deleted_at, :datetime
    add_column :facturas_compra_detalle, :deleted_at, :datetime
    add_column :ordenes_compra, :deleted_at, :datetime
    add_column :ordenes_compra_detalle, :deleted_at, :datetime
    add_column :ordenes_devolucion, :deleted_at, :datetime
    add_column :ordenes_devolucion_detalle, :deleted_at, :datetime
    add_column :pedidos_compra, :deleted_at, :datetime
    add_column :pedidos_compra_detalle, :deleted_at, :datetime
    add_column :pedidos_cotizacion, :deleted_at, :datetime
    add_column :pedidos_cotizacion_detalle, :deleted_at, :datetime
  end
end

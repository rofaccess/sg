class ModifyDecimals < ActiveRecord::Migration
  def change
  	remove_column :facturas_compra, :total_factura
  	remove_column :facturas_compra, :total_iva
  	remove_column :facturas_compra_detalle, :costo_unitario
  	add_column :facturas_compra, :total_factura, :decimal
  	add_column :facturas_compra, :total_iva, :decimal
  	add_column :facturas_compra_detalle, :costo_unitario, :decimal
  end
end

class RemoveIvaUnitarioFromFacturasCompraDetalle < ActiveRecord::Migration
  def change
  	remove_column :facturas_compra_detalle, :iva_unitario
  end
end

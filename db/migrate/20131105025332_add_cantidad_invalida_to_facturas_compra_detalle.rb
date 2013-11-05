class AddCantidadInvalidaToFacturasCompraDetalle < ActiveRecord::Migration
  def change
  	add_column :facturas_compra_detalle, :cantidad_invalida, :integer ,default: 0
  end
end

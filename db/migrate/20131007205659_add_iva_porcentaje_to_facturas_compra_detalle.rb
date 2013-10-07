class AddIvaPorcentajeToFacturasCompraDetalle < ActiveRecord::Migration
  def change
  	add_column :facturas_compra_detalle, :iva_porcentaje, :string
  end
end

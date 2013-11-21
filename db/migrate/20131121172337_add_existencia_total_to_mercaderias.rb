class AddExistenciaTotalToMercaderias < ActiveRecord::Migration
  def change
  	add_column :mercaderias, :existencia_total, :integer, null: false, default: 0
  	add_column :facturas_compra_detalle, :cantidad_credito, :integer, null: false, default: 0
  end
end

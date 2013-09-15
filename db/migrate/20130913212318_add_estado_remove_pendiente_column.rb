class AddEstadoRemovePendienteColumn < ActiveRecord::Migration
  def change
  	add_column :pedidos_compra, :estado, :string
  	remove_column :pedidos_compra, :pendiente
  end
end

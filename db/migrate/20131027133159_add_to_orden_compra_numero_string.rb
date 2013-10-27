class AddToOrdenCompraNumeroString < ActiveRecord::Migration
  def change
  	remove_column :ordenes_compras, :numero
  	add_column :ordenes_compras, :numero, :string, limit: 15
  end
end

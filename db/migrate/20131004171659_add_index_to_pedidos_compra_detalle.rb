class AddIndexToPedidosCompraDetalle < ActiveRecord::Migration
  def change
  	add_index :pedidos_compra_detalle, :componente_id, unique: true
  end
end

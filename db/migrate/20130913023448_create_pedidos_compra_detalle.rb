class CreatePedidosCompraDetalle < ActiveRecord::Migration
  def change
    create_table :pedidos_compra_detalle do |t|
      t.integer :pedido_compra_id
      t.integer :componente_id
      t.integer :cantidad

      t.timestamps
    end
  end
end

class CreatePedidosCompraDetalle < ActiveRecord::Migration
  def change
    create_table :pedidos_compra_detalle do |t|
      t.integer :pedido_compra_id ,null: false
      t.integer :componente_id    ,null: false
      t.integer :cantidad         ,null: false ,default: 0

      t.timestamps
    end

    add_foreign_key(:pedidos_compra_detalle, :pedidos_compra, dependent: :delete, column: 'pedido_compra_id', name: 'pedido_compra_detalle_pedido_foreign_key')
  	add_foreign_key(:pedidos_compra_detalle, :mercaderias, column: 'componente_id', name: 'pedido_compra_detalle_componente_foreign_key', options: 'ON DELETE RESTRICT')
  end
end

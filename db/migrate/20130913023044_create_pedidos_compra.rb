class CreatePedidosCompra < ActiveRecord::Migration
  def change
    create_table :pedidos_compra do |t|
      t.integer :numero
      t.datetime :fecha
      t.boolean :pendiente

      t.timestamps
    end
  end
end

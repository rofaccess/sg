class CreatePedidosCompra < ActiveRecord::Migration
  def change
    create_table :pedidos_compra do |t|
      t.string   :numero, null: false, limit: 15
      t.datetime :fecha
      t.string   :estado, null: true,  limit: 15

      t.timestamps
    end
  end
end

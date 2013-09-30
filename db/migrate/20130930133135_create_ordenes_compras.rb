class CreateOrdenesCompras < ActiveRecord::Migration
  def change
    create_table :ordenes_compras do |t|
      t.integer :numero
      t.date :fecha
      t.decimal :costo_total
      t.string :estado
      t.integer :user_id
      t.integer :proveedor_id
      t.integer :pedido_cotizacion_id

      t.timestamps
    end
  end
end

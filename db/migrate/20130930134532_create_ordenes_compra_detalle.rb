class CreateOrdenesCompraDetalle < ActiveRecord::Migration
  def change
    create_table :ordenes_compra_detalle do |t|
      t.integer :orden_compra_id
      t.integer :componente_id
      t.decimal :costo_unitario
      t.integer :cantidad_requerida
      t.integer :cantidad_recibida

      t.timestamps
    end
  end
end

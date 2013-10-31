class CreateOrdenesCompraDetalle < ActiveRecord::Migration
  def change
    create_table :ordenes_compra_detalle do |t|
      t.integer :orden_compra_id    ,null: false
      t.integer :componente_id      ,null: false
      t.decimal :costo_unitario     ,null: false , default: 0
      t.integer :cantidad_requerida ,null: false , default: 0
      t.integer :cantidad_recibida  ,default: 0

      t.timestamps
    end

    add_foreign_key(:ordenes_compra_detalle, :ordenes_compra, dependent: :delete, column: 'orden_compra_id', name: 'orden_compra_detalle_orden_foreign_key')
    add_foreign_key(:ordenes_compra_detalle, :mercaderias, column: 'componente_id', name: 'orden_compra_detalle_componente_foreign_key', options: 'ON DELETE RESTRICT')
  end
end

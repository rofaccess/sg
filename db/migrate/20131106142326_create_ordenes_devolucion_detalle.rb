class CreateOrdenesDevolucionDetalle < ActiveRecord::Migration
  def change
    create_table :ordenes_devolucion_detalle do |t|
      t.integer  :orden_devolucion_id             ,null: false
      t.integer  :componente_id                   ,null: false
      t.integer  :cantidad_devuelta               ,null: false, default: 0
      t.decimal  :costo_unitario                  ,default: 0
      t.string   :iva                             ,default: 0
      t.string   :motivo                          ,default: '' ,limit: Domain::DESCRIPCION
      t.integer :orden_compra_detalle_id         ,null: false

      t.timestamps
    end

    add_foreign_key(:ordenes_devolucion_detalle, :ordenes_devolucion, column: 'orden_devolucion_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:ordenes_devolucion_detalle, :mercaderias, column: 'componente_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:ordenes_devolucion_detalle, :ordenes_compra_detalle, column: 'orden_compra_detalle_id', options: 'ON DELETE RESTRICT')
  end
end

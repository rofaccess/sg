class CreateFacturasCompraDetalle < ActiveRecord::Migration
  def change
    create_table :facturas_compra_detalle do |t|
      t.integer :factura_compra_id ,null: false
      t.integer :componente_id     ,null: false
      t.integer :cantidad          ,null: false ,default: 0
      t.decimal :costo_unitario    ,null: false ,default: 0
      t.string  :iva_valor         ,null: false, limit: Domain::IVA
      t.integer :orden_compra_detalle_id ,null:false

      t.timestamps
    end

    add_foreign_key(:facturas_compra_detalle, :facturas_compra, column: 'factura_compra_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:facturas_compra_detalle, :mercaderias, column: 'componente_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:facturas_compra_detalle, :ordenes_compra_detalle, column: 'orden_compra_detalle_id', options: 'ON DELETE RESTRICT')
  end
end

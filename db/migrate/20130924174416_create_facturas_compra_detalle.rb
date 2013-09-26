class CreateFacturasCompraDetalle < ActiveRecord::Migration
  def change
    create_table :facturas_compra_detalle do |t|
      t.integer :factura_compra_id, null: false
      t.integer :componente_id,     null: false
      t.integer :cantidad,     			null: false
      t.decimal :costo_unitario,    null: false, precision: 10, scale: 2
      t.decimal :iva_unitario,      null: false, precision: 10, scale: 2

      t.timestamps
    end

    add_foreign_key(:facturas_compra_detalle, :facturas_compra, column: 'factura_compra_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:facturas_compra_detalle, :componentes, column: 'componente_id', options: 'ON DELETE RESTRICT')
  end
end

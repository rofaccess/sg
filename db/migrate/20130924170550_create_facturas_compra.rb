class CreateFacturasCompra < ActiveRecord::Migration
  def change
    create_table :facturas_compra do |t|
      t.string   :numero,            null: false, limit: 15
      t.datetime :fecha_compra,      null: true
      t.datetime :fecha_vencimiento, null: true
      t.decimal  :total_factura,     null: false, precision: 10, scale: 2
      t.decimal  :total_iva,         null: false, precision: 10, scale: 2
      t.string   :estado,            null: true,  limit: 15
      t.integer  :orden_compra_id,   null: true
      t.integer  :proveedor_id,      null: true
      t.integer  :condicion_pago_id, null: true
      t.integer  :plazo_pago_id,     null: true
      t.integer  :user_id,           null: false

      t.timestamps
    end

  #add_foreign_key(:facturas_compra, :ordenes_compras, column: 'orden_compra_id', options: 'ON DELETE RESTRICT')
  add_foreign_key(:facturas_compra, :personas, column: 'proveedor_id', options: 'ON DELETE RESTRICT')
  add_foreign_key(:facturas_compra, :condiciones_pago, column: 'condicion_pago_id', options: 'ON DELETE RESTRICT')
	add_foreign_key(:facturas_compra, :plazos_pago, column: 'plazo_pago_id', options: 'ON DELETE RESTRICT')
	add_foreign_key(:facturas_compra, :users, column: 'user_id', options: 'ON DELETE RESTRICT')
  end
end

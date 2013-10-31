class CreateFacturasCompra < ActiveRecord::Migration
  def change
    create_table :facturas_compra do |t|
      t.string   :numero        ,default: '' ,limit: Domain::NUMERO_DOC_COM ,null: false
      t.string   :estado        ,default: '' ,limit: Domain::ESTADO ,null: false
      t.datetime :fecha         ,null: false
      t.decimal  :total_factura ,default: 0  ,null: false
      t.decimal  :total_iva     ,default: 0  ,null: false
      t.integer  :orden_compra_id   ,null: false
      t.integer  :proveedor_id      ,null: false
      t.integer  :condicion_pago_id ,null: false
      t.integer  :plazo_pago_id
      t.integer  :user_id           ,null: false

      t.timestamps
    end

  add_foreign_key(:facturas_compra, :personas, column: 'proveedor_id', options: 'ON DELETE RESTRICT')
  add_foreign_key(:facturas_compra, :condiciones_pago, column: 'condicion_pago_id', options: 'ON DELETE RESTRICT')
	add_foreign_key(:facturas_compra, :plazos_pago, column: 'plazo_pago_id', options: 'ON DELETE RESTRICT')
	add_foreign_key(:facturas_compra, :users, column: 'user_id', options: 'ON DELETE RESTRICT')
  add_foreign_key(:facturas_compra, :ordenes_compra, column: 'orden_compra_id', options: 'ON DELETE RESTRICT')
  end
end

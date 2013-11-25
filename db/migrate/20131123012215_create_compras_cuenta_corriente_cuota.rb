class CreateComprasCuentaCorrienteCuota < ActiveRecord::Migration
  def change
    create_table :compras_cuenta_corriente_cuota do |t|
      t.integer  :compra_cuenta_corriente_factura_id ,null: false
      t.string   :cuota_numero   ,default: '' ,limit: Domain::CUOTA  ,null: false
      t.datetime :fecha_vencimiento  ,null: false
      t.datetime :fecha_pago
      t.decimal  :importe_cuota      ,default: 0  ,null: false

      t.timestamps
    end
    add_foreign_key(:compras_cuenta_corriente_cuota, :compras_cuenta_corriente_factura, column: 'compra_cuenta_corriente_factura_id', name: 'c_cta_cte_factura_cuota_fk', options: 'ON DELETE CASCADE')
  end
end

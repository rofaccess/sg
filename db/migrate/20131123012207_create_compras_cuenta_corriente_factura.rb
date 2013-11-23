class CreateComprasCuentaCorrienteFactura < ActiveRecord::Migration
  def change
    create_table :compras_cuenta_corriente_factura do |t|
      t.integer  :compra_cuenta_corriente_id ,null: false
      t.integer  :factura_compra_id          ,null: false
      t.decimal  :saldo_factura ,default: 0  ,null: false
      t.string   :cuotas        ,default: '' ,limit: Domain::CUOTA  ,null: false
      t.datetime :deleted_at    ,default: nil

      t.timestamps
    end

    add_foreign_key(:compras_cuenta_corriente_factura, :compras_cuenta_corriente, column: 'compra_cuenta_corriente_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:compras_cuenta_corriente_factura, :facturas_compra, column: 'factura_compra_id', options: 'ON DELETE RESTRICT')
  end
end

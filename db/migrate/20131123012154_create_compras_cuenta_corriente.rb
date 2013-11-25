class CreateComprasCuentaCorriente < ActiveRecord::Migration
  def change
    create_table :compras_cuenta_corriente do |t|
      t.integer  :proveedor_id       ,null: false
      t.datetime :fecha_creacion     ,null: false
      t.decimal  :saldo         ,default: 0  ,null: false
      t.decimal  :monto_debito  ,default: 0
      t.decimal  :monto_credito ,default: 0
      t.datetime :deleted_at         ,default: nil

      t.timestamps
    end

    add_foreign_key(:compras_cuenta_corriente, :personas, column: 'proveedor_id', options: 'ON DELETE RESTRICT')
  end
end

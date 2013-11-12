class CreateAsientosContableDetalle < ActiveRecord::Migration
  def change
    create_table :asientos_contable_detalle do |t|
      t.integer :asiento_contable_id  ,null: false
      t.integer :cuenta_contable_id ,null: false
      t.string  :tipo_partida_doble ,null: false ,default: '' ,limit: Domain::TIPO_PARTIDA_DOBLE
      t.decimal :monto              ,null: false ,default: 0

      t.timestamps
    end

    add_foreign_key(:asientos_contable_detalle, :asientos_contable, column: 'asiento_contable_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:asientos_contable_detalle, :cuentas_contable, column: 'cuenta_contable_id', options: 'ON DELETE RESTRICT')
  end
end

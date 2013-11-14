class CreateAsientosModeloDetalle < ActiveRecord::Migration
  def change
    create_table :asientos_modelo_detalle do |t|
      t.integer :asiento_modelo_id  ,null: false
      t.integer :cuenta_contable_id ,null: false
      t.string  :tipo_partida_doble ,null: false ,default: '' ,limit: Domain::TIPO_PARTIDA_DOBLE
      t.string  :valor              ,null: false ,default: '' ,limit: Domain::NOMBRE

      t.timestamps
    end

    add_foreign_key(:asientos_modelo_detalle, :asientos_modelo, column: 'asiento_modelo_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:asientos_modelo_detalle, :cuentas_contable, column: 'cuenta_contable_id', options: 'ON DELETE RESTRICT')
  end
end

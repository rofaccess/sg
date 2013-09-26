class CreatePlazosPagoDetalle < ActiveRecord::Migration
  def change
    create_table :plazos_pago_detalle do |t|
      t.integer :plazo_pago_id,    null: false
      t.string  :dias_vencimiento, null: false, limit:3

      t.timestamps
    end

    add_foreign_key(:plazos_pago_detalle, :plazos_pago, column: 'plazo_pago_id', options: 'ON DELETE CASCADE')
  end
end

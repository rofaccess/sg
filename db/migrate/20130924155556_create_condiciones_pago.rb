class CreateCondicionesPago < ActiveRecord::Migration
  def change
    create_table :condiciones_pago do |t|
      t.string :nombre, null: false, limit: 7

      t.timestamps
    end
  end
end

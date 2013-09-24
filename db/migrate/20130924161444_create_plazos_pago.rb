class CreatePlazosPago < ActiveRecord::Migration
  def change
    create_table :plazos_pago do |t|
      t.string :nombre,      null: false, limit: 50
      t.string :cuotas,      null: false, limit: 3
      t.string :descripcion, null: true,  limit: 50

      t.timestamps
    end
  end
end

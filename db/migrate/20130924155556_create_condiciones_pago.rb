class CreateCondicionesPago < ActiveRecord::Migration
  def change
    create_table :condiciones_pago do |t|
      t.string :nombre, default: '' ,limit: Domain::CONDICION ,null: false

      t.timestamps
    end
  end
end

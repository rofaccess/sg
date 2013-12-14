class CreatePlazosPago < ActiveRecord::Migration
  def change
    create_table :plazos_pago do |t|
      t.string :nombre      ,default: '' ,limit: Domain::NOMBRE ,null: false
      t.string :cuotas      ,default: '' ,limit: Domain::CUOTA  ,null: false
      t.string :descripcion ,default: '' ,limit: Domain::DESCRIPCION

      t.timestamps
    end

    #add_index :plazos_pago, :nombre, unique: true
  end
end

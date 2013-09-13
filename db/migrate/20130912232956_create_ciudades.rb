class CreateCiudades < ActiveRecord::Migration
  def change
    create_table :ciudades do |t|
      t.string 	:nombre,	null: false, default: '', limit: 100
      t.integer :estado_id,	null: false

      t.timestamps
    end
  end
end

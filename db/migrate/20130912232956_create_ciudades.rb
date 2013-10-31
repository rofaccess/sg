class CreateCiudades < ActiveRecord::Migration
  def change
    create_table :ciudades do |t|
      t.string :nombre       ,default: '' ,limit: Domain::NOMBRE   ,null: false
      t.integer :estado_id ,null: false

      t.timestamps
    end

    add_index :ciudades, :nombre, unique: true
    add_foreign_key(:ciudades, :estados, dependent: :delete, column: 'estado_id')
  end
end

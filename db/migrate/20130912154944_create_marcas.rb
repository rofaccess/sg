class CreateMarcas < ActiveRecord::Migration
  def change
    create_table :marcas do |t|
      t.string :nombre ,default: '' ,limit: Domain::NOMBRE ,null: false

      t.timestamps
    end

    #add_index :marcas, :nombre, unique: true
  end
end

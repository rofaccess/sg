class CreateComponentesCategoria < ActiveRecord::Migration
  def change
    create_table :componentes_categoria do |t|
      t.string :nombre ,default: '' ,limit: Domain::NOMBRE ,null: false

      t.timestamps
    end

    #add_index :componentes_categoria, :nombre, unique: true
  end
end

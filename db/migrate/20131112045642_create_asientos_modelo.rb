class CreateAsientosModelo < ActiveRecord::Migration
  def change
    create_table :asientos_modelo do |t|
      t.string :concepto ,null: false ,default: '' ,limit: Domain::DESCRIPCION
      t.string :origen   ,null: false ,default: '' ,limit: Domain::NOMBRE

      t.timestamps
    end
  end
end

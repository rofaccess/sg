class CreateComponentes < ActiveRecord::Migration
  def change
    create_table :componentes do |t|
      t.string :nombre
      t.string :numero_serie
      t.decimal :costo
      t.integer :marca_id
      t.integer :componente_categoria_id

      t.timestamps
    end
  end
end

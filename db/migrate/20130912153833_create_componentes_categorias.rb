class CreateComponentesCategorias < ActiveRecord::Migration
  def change
    create_table :componentes_categorias do |t|
      t.string :nombre

      t.timestamps
    end
  end
end

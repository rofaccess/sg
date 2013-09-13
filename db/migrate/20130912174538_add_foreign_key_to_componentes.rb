class AddForeignKeyToComponentes < ActiveRecord::Migration
  def change
  	add_index :componentes, :marca_id
  	add_index :componentes, :componente_categoria_id
  end
end

class CreateComponentesCategoriasPersonas < ActiveRecord::Migration
  def change
    create_table :componentes_categorias_personas, id: false do |t|
    	t.belongs_to :componente_categoria, null: false
    	t.belongs_to :proveedor, null: false
    end
  add_index :componentes_categorias_personas, [:componente_categoria_id, :proveedor_id], name: 'categorias_personas'
  end
end

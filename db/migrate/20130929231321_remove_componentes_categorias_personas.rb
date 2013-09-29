class RemoveComponentesCategoriasPersonas < ActiveRecord::Migration
  def change
  	drop_table :componentes_categorias_personas
  end
end

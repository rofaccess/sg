class AddForeignKeyToComponentes2 < ActiveRecord::Migration
  def change
  	add_foreign_key(:componentes, :marcas, column: 'marca_id', name: 'componente_marca_foreign_key', options: 'ON DELETE RESTRICT')
  	add_foreign_key(:componentes, :componentes_categorias, column: 'componente_categoria_id', name: 'componente_categoria_foreign_key', options: 'ON DELETE RESTRICT')
  end
end

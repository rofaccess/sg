class CreateComponenteCategoriasProviders < ActiveRecord::Migration
  def change
    create_table :componentes_categorias_providers, id: false do |t|
    	t.belongs_to :componente_categoria, null: false
    	t.belongs_to :provider, null: false
    end
    add_index :componentes_categorias_providers, [:componente_categoria_id, :provider_id], name: 'categorias_proveedores'
  end
end

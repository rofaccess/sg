class RemoveProviders < ActiveRecord::Migration
  def change
  	drop_table :componentes_categorias_providers
  	drop_table :providers
  end
end

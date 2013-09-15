class AddCiudadIdToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :ciudad_id, :integer
    add_foreign_key(:providers, :ciudades, dependent: :delete, column: 'ciudad_id')
  end
end

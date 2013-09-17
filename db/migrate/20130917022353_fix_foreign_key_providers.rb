class FixForeignKeyProviders < ActiveRecord::Migration
  def change
  	remove_foreign_key(:providers, name: 'providers_ciudad_id_fk')
    add_foreign_key(:providers, :ciudades, column: 'ciudad_id', options: 'ON DELETE RESTRICT')
  end
end

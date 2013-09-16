class FixForeignKeyLocalidades < ActiveRecord::Migration
  def change
    remove_foreign_key(:ciudades, name: 'ciudades_estado_id_fk')
    add_foreign_key(:ciudades, :estados, dependent: :delete, column: 'estado_id')
  end
end

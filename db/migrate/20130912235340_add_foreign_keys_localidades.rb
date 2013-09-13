class AddForeignKeysLocalidades < ActiveRecord::Migration
  def change
    add_foreign_key(:estados, :paises, dependent: :delete, column: 'pais_id')
    add_foreign_key(:ciudades, :paises, dependent: :delete, column: 'estado_id')
  end
end

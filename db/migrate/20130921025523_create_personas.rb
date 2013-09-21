class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string   :nombre,                 null: false, limit: 50
      t.string   :ruc,                    null: true,  limit: 20
      t.string   :documento_numero,       null: true,  limit: 20
      t.string   :direccion,              null: true,  limit: 70
      t.string   :email,                  null: true,  limit: 60
      t.string   :edad,                   null: true,  limit: 3
      t.string   :sexo,                   null: true,  limit: 10
      t.datetime :fecha_nacimiento,       null: true
      t.integer  :documento_identidad_id, null: true
      t.integer  :ciudad_id,              null: true

      t.timestamps
    end

  add_foreign_key(:personas, :ciudades, column: 'ciudad_id', options: 'ON DELETE RESTRICT')
  end
end

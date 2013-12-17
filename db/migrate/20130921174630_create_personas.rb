class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string   :nombre                  ,default: '' ,limit: Domain::NOMBRE ,null: false
      t.string   :apellido                ,default: '' ,limit: Domain::NOMBRE
      t.string   :ruc                     ,default: '' ,limit: Domain::RUC
      t.string   :documento_id_num        ,default: '' ,limit: Domain::NUMERO_DOC_IDE
      t.string   :direccion               ,default: '' ,limit: Domain::DIRECCION
      t.string   :email                   ,default: '' ,limit: Domain::EMAIL
      t.string   :edad                    ,default: '' ,limit: Domain::EDAD
      t.string   :sexo                    ,default: '' ,limit: Domain::SEXO
      t.datetime :fecha_nacimiento
      t.integer  :documento_identidad_id
      t.integer  :ciudad_id
      t.string   :type                    ,default: '' ,limit: Domain::TIPO_PERSONA

      t.timestamps
    end

  add_index :personas, :email, unique: true
  add_foreign_key(:personas, :ciudades, column: 'ciudad_id', options: 'ON DELETE RESTRICT')
  end
end
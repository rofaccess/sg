class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string  :nombre      ,default: '' ,limit: Domain::NOMBRE   ,null: false
      t.string  :abreviatura ,default: '' ,limit: Domain::ABREVIATURA
      t.integer :pais_id	 ,null: false

      t.timestamps
    end

    add_index :estados, :nombre, unique: true
    add_index :estados, :abreviatura, unique: true
    add_foreign_key(:estados, :paises, dependent: :delete, column: 'pais_id')
  end
end

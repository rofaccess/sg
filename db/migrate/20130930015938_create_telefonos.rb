class CreateTelefonos < ActiveRecord::Migration
  def change
    create_table :telefonos do |t|
    	 t.string   :numero ,default: '' ,limit: Domain::TELEFONO  ,null: false
    	 t.integer  :persona_id, null: false
    end

  add_index :telefonos, :numero
  add_foreign_key(:telefonos, :personas, column: 'persona_id', options: 'ON DELETE CASCADE')
  end
end


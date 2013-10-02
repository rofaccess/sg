class CreateTelefonos < ActiveRecord::Migration
  def change
    create_table :telefonos do |t|
    	 t.string   :numero,     null: false, limit: 15
    	 t.integer  :persona_id, null: false
    end

  add_foreign_key(:telefonos, :personas, column: 'persona_id', options: 'ON DELETE CASCADE')
  end
end


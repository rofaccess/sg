class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string 		:nombre,		null: false, default: '', limit: 100
      t.string 		:abreviatura,	null: false, default: '', limit: 5
      t.integer 	:pais_id,		null: false

      t.timestamps
    end
  end
end

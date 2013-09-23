class CreateProveedores < ActiveRecord::Migration
  def change
    create_table :proveedores do |t|
      t.integer :persona_id, null: false

      t.timestamps
    end

  add_index :proveedores, :persona_id, unique: true
  add_foreign_key(:proveedores, :personas, dependent: :delete, column: 'persona_id')
  end
end
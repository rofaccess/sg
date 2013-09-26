class CreateConfiguraciones < ActiveRecord::Migration
  def change
    create_table :configuraciones do |t|
      t.string :nombre
      t.string :direccion

      t.timestamps
    end
  end
end

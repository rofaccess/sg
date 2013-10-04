class CreateIvas < ActiveRecord::Migration
  def change
    create_table :ivas do |t|
      t.string  :abreviatura, null: false, limit: 5
      t.decimal :porcentaje,  null: false, precision: 10, scale: 2
      t.string  :descripcion, null: true, limit: 50

      t.timestamps
    end
  end
end

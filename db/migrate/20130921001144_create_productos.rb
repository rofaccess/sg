class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :codigo,          null: false, limit: 15
      t.string :nombre,          null: false, limit: 50
      t.string :descripcion,     null: true,  limit: 50
      t.decimal :costo_unitario, null:false,  precision: 10, scale: 2

      t.timestamps
    end

    add_index :productos, :codigo, unique: true
  end
end

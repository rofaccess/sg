class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombre
      t.string :marca
      t.decimal :precio_unitario

      t.timestamps
    end
  end
end

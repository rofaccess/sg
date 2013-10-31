class CreateMercaderias < ActiveRecord::Migration
  def change
    create_table :mercaderias do |t|
      t.string  :nombre      ,default: '' ,limit: Domain::NOMBRE      ,null: false
      t.string  :codigo      ,default: '' ,limit: Domain::CODIGO
      t.string  :descripcion ,default: '' ,limit: Domain::DESCRIPCION
      t.string  :type        ,default: '' ,limit: Domain::TIPO_MERCADERIA
      t.decimal :costo 	     ,null: false
      t.integer :marca_id
      t.integer :iva_id      ,null: false
      t.integer :componente_categoria_id

      t.timestamps
    end

    add_index :mercaderias, :codigo, unique: true
    add_index :mercaderias, :nombre, unique: true
    add_foreign_key(:mercaderias, :marcas, column: 'marca_id', options: 'ON DELETE RESTRICT')
  	add_foreign_key(:mercaderias, :componentes_categoria, column: 'componente_categoria_id', options: 'ON DELETE RESTRICT')
 	  add_foreign_key(:mercaderias, :ivas, column: 'iva_id', options: 'ON DELETE RESTRICT')
  end
end
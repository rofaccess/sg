class CreateOrdenesDevolucion < ActiveRecord::Migration
  def change
    create_table :ordenes_devolucion do |t|
      t.string   :numero                  ,default: '' ,limit: Domain::NUMERO_DOC_COM ,null: false
      t.decimal  :total_orden             ,default: 0  ,null: false
      t.decimal  :total_iva               ,default: 0  ,null: false
      t.datetime :fecha_generado          ,null: false
      t.string   :motivo                  ,default: '' ,limit: Domain::DESCRIPCION
      t.integer  :factura_compra_id       ,null: false
      t.integer  :proveedor_id            ,null: false
      t.integer  :user_id                 ,null: false

      t.timestamps
    end

    add_index :ordenes_devolucion, :numero, unique: true
    add_foreign_key(:ordenes_devolucion, :facturas_compra, column: 'factura_compra_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:ordenes_devolucion, :personas, column: 'proveedor_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:ordenes_devolucion, :users, column: 'user_id', options: 'ON DELETE RESTRICT')
  end
end


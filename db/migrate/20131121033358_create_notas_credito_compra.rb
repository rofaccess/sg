class CreateNotasCreditoCompra < ActiveRecord::Migration
  def change
    create_table :notas_credito_compra do |t|
      t.string   :numero        ,default: '' ,limit: Domain::NUMERO_DOC_COM ,null: false
      t.datetime :fecha         ,null: false
      t.decimal  :total ,default: 0  ,null: false
      t.integer  :factura_compra_id  ,null: false
      t.integer  :proveedor_id       ,null: false
      t.integer  :user_id            ,null: false
      t.timestamps
    end

    add_foreign_key(:notas_credito_compra, :personas, column: 'proveedor_id', options: 'ON DELETE RESTRICT')
	add_foreign_key(:notas_credito_compra, :users, column: 'user_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:notas_credito_compra, :facturas_compra, column: 'factura_compra_id', options: 'ON DELETE RESTRICT')
  end
end

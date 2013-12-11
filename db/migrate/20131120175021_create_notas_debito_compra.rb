class CreateNotasDebitoCompra < ActiveRecord::Migration
  def change
    create_table :notas_debito_compra do |t|
 	    t.string   :numero        ,default: '' ,limit: Domain::NUMERO_DOC_COM ,null: false
      t.string   :estado        ,default: '' ,limit: Domain::ESTADO
      t.string   :motivo        ,default: '' ,limit: Domain::DESCRIPCION ,null: false
      t.datetime :fecha         ,null: false
      t.decimal  :total         ,default: 0  ,null: false
      t.integer  :proveedor_id  ,null: false
      t.integer  :user_id       ,null: false

      t.timestamps
    end

    add_foreign_key(:notas_debito_compra, :personas, column: 'proveedor_id', options: 'ON DELETE RESTRICT')
	  add_foreign_key(:notas_debito_compra, :users, column: 'user_id', options: 'ON DELETE RESTRICT')
  end
end

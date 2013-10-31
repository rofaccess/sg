class CreatePedidosCompra < ActiveRecord::Migration
  def change
    create_table :pedidos_compra do |t|
      t.string   :numero ,default: '' ,limit: Domain::NUMERO_DOC_COM ,null: false
      t.string   :estado ,default: '' ,limit: Domain::ESTADO         ,null: false
      t.datetime :fecha_generado
      t.datetime :fecha_procesado
      t.datetime :fecha_ordenado
      t.decimal  :total_estimado  ,default: 0

      t.timestamps
    end

    add_index :pedidos_compra, :numero, unique: true
  end
end

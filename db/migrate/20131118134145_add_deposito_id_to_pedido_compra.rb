class AddDepositoIdToPedidoCompra < ActiveRecord::Migration
  def change
  	add_column :pedidos_compra, :deposito_id, :integer, null: false
  	add_column :depositos_stock, :pedido_generado, :string, limit: 2, default: "No"
  	add_foreign_key(:pedidos_compra, :depositos, column: 'deposito_id', options: 'ON DELETE RESTRICT')
  end
end

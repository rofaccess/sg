class AddDepositoDestinoToFacturasCompra < ActiveRecord::Migration
  def change
  	add_column :facturas_compra, :deposito_destino_id, :integer
  	add_foreign_key(:facturas_compra, :depositos, column: 'deposito_destino_id', options: 'ON DELETE RESTRICT')
  end
end

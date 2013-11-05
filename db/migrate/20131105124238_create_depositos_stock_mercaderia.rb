class CreateDepositosStockMercaderia < ActiveRecord::Migration
  def change
    create_table :depositos_stock_mercaderia do |t|
      t.integer :deposito_id    ,null: false
      t.integer :mercaderia_id  ,null: false
      t.integer :existencia     ,null: false
      t.integer :existencia_min ,null: false
      t.integer :existencia_max ,null: false

      t.timestamps
    end

    add_foreign_key(:depositos_stock_mercaderia, :depositos, column: 'deposito_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:depositos_stock_mercaderia, :mercaderias, column: 'mercaderia_id', options: 'ON DELETE RESTRICT')
  end
end

class CreateDepositosStock < ActiveRecord::Migration
  def change
    create_table :depositos_stock do |t|
      t.integer :deposito_id    ,null: false
      t.integer :mercaderia_id  ,null: false
      t.integer :existencia     ,null: false ,default: 0
      t.integer :existencia_min ,null: false ,default: 0
      t.integer :existencia_max ,null: false ,default: 0

      t.timestamps
    end

    add_foreign_key(:depositos_stock, :depositos, column: 'deposito_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:depositos_stock, :mercaderias, column: 'mercaderia_id', options: 'ON DELETE RESTRICT')
  end
end

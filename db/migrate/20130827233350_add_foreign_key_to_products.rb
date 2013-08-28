class AddForeignKeyToProducts < ActiveRecord::Migration
  def change
  	add_index :products, :provider_id
  end
end

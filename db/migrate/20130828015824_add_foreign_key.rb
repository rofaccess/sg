class AddForeignKey < ActiveRecord::Migration
  def change 
  	add_foreign_key(:products, :providers, dependent: :delete, column: 'provider_id', name: 'product_provider_foreign_key')
  end
end

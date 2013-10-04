class AddIvaIdToComponentes < ActiveRecord::Migration
  def change
  	add_column :componentes, :iva_id, :integer
  	add_foreign_key(:componentes, :ivas, column: 'iva_id', options: 'ON DELETE RESTRICT')
  end
end

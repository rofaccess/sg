class AddDeletedAtToNotas < ActiveRecord::Migration
  def change
  	add_column :notas_debito_compra, :deleted_at, :datetime, null: true, default: nil
  	add_column :notas_credito_compra, :deleted_at, :datetime, null: true, default: nil
  	add_column :notas_credito_compra_detalle, :deleted_at, :datetime, null: true, default: nil
  end
end

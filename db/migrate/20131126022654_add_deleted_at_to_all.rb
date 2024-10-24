class AddDeletedAtToAll < ActiveRecord::Migration
  def change
  	add_column :ciudades, :deleted_at, :datetime, null: true, default: nil
  	add_column :componentes_categoria, :deleted_at, :datetime, null: true, default: nil
  	add_column :estados, :deleted_at, :datetime, null: true, default: nil
  	add_column :marcas, :deleted_at, :datetime, null: true, default: nil
  	add_column :mercaderias, :deleted_at, :datetime, null: true, default: nil
  	add_column :paises, :deleted_at, :datetime, null: true, default: nil
		add_column :asientos_contable, :deleted_at, :datetime, null: true, default: nil
  end
end

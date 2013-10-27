class AddSimboloMonedaToConfiguraciones < ActiveRecord::Migration
  def change
  	add_column :configuraciones, :simbolo_moneda, :string, limit: 5
  end
end

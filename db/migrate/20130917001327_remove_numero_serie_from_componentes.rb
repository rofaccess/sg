class RemoveNumeroSerieFromComponentes < ActiveRecord::Migration
  def change
  	remove_column :componentes, :numero_serie
  end
end

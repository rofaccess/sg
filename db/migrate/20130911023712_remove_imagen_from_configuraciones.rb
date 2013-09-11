class RemoveImagenFromConfiguraciones < ActiveRecord::Migration
  def change
    remove_column :configuraciones, :imagen, :string
  end
end

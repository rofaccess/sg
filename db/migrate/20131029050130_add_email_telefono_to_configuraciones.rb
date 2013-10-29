class AddEmailTelefonoToConfiguraciones < ActiveRecord::Migration
  def change
    add_column :configuraciones, :email, :string, default: '', limit: 150
    add_column :configuraciones, :telefono, :string, default: '', limit: 50
  end
end

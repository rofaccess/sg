class AddUsuarioAdminIdToConfiguraciones < ActiveRecord::Migration
  def change
  	add_column :configuraciones, :usuario_admin_id, :integer, null: false, default: nil
  end
end

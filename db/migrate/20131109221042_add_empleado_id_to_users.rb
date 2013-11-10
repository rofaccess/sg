class AddEmpleadoIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :empleado_id, :integer, null: true
    change_column :users, :email, :string, :default => "", :null => false, :unique => false
  end
end

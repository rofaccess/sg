class CreateRolesInterfaces < ActiveRecord::Migration
  def change
    create_table :roles_interfaces, id: false do |t|
      t.integer  :role_id	  ,null: false
      t.integer  :interfaz_id ,null: false	
      t.timestamps
    end
    add_foreign_key(:roles_interfaces, :roles, column: 'role_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:roles_interfaces, :interfaces, column: 'interfaz_id', options: 'ON DELETE CASCADE')
  	execute "ALTER TABLE roles_interfaces ADD PRIMARY KEY (role_id, interfaz_id);"
  end
end

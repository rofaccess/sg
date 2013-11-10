class RemoveUniqueFromPersonas < ActiveRecord::Migration
  def change
  	remove_index :personas, :email
  end
end

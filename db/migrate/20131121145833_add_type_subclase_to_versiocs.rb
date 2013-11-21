class AddTypeSubclaseToVersiocs < ActiveRecord::Migration
  def change
  	add_column :versions, :type_subclase, :string, null: true, default: nil
  end
end

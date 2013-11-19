class AddDeletedAtToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :deleted_at, :datetime
    add_column :configuraciones, :deleted_at, :datetime
  end
end

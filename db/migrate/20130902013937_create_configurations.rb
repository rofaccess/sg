class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :company_name
      t.blob :image

      t.timestamps
    end
  end
end

class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :company_name
      t.string :image

      t.timestamps
    end
  end
end

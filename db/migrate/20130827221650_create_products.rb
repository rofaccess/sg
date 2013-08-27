class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :mark
      t.decimal :unit_price

      t.timestamps
    end
  end
end

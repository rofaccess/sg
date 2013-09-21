class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :ruc
      t.string :phone
      t.string :address
      t.string :email
      t.timestamps
    end
  end
end

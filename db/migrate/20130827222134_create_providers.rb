class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :ruc
      t.string :adress
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end

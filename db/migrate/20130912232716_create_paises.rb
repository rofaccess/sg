class CreatePaises < ActiveRecord::Migration
  def change
    create_table :paises do |t|
      t.string :nombre,			null: false, default: '', limit: 100
      t.string :abreviatura,	null: false, default: '', limit: 5

      t.timestamps
    end
  end
end

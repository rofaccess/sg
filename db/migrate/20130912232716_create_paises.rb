class CreatePaises < ActiveRecord::Migration
  def change
    create_table :paises do |t|
      t.string :nombre       ,default: '' ,limit: Domain::NOMBRE   ,null: false
      t.string :abreviatura  ,default: '' ,limit: Domain::ABREVIATURA

      t.timestamps
    end

    add_index :paises, :nombre     , unique: true
    add_index :paises, :abreviatura, unique: true
  end
end

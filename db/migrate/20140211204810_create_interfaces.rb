class CreateInterfaces < ActiveRecord::Migration
  def change
    create_table :interfaces do |t|
      t.string   :nombre   ,default: '' ,limit: Domain::INTERFAZ  ,null: false
      t.string   :seccion  ,default: '' ,limit: Domain::INTERFAZ  ,null: false

      t.timestamps
    end
  end
end

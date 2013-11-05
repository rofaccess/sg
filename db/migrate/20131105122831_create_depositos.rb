class CreateDepositos < ActiveRecord::Migration
  def change
    create_table :depositos do |t|
      t.string  :nombre ,default: '' ,limit: Domain::NOMBRE ,null: false
      t.string  :descripcion ,default: '' ,limit: Domain::DESCRIPCION
      t.boolean :disponible, default: true, null: false
      t.timestamps
    end
  end
end

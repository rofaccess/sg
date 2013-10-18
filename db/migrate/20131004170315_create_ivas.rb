class CreateIvas < ActiveRecord::Migration
  def change
    create_table :ivas do |t|
      t.string  :valor, null: false, limit: 4
      t.string  :descripcion, null: true, limit: 50

      t.timestamps
    end
  end
end

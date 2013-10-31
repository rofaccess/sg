class CreateIvas < ActiveRecord::Migration
  def change
    create_table :ivas do |t|
      t.string  :valor       ,default: '' ,limit: Domain::IVA         ,null: false
      t.string  :descripcion ,default: '' ,limit: Domain::DESCRIPCION

      t.timestamps
    end

    add_index :ivas, :valor, unique: true
  end
end

class CreateConfiguraciones < ActiveRecord::Migration
  def change
    create_table :configuraciones do |t|
      t.string :nombre          ,default: '' ,limit: Domain::NOMBRE    ,null: false
      t.string :direccion       ,default: '' ,limit: Domain::DIRECCION ,null: false
      t.string :simbolo_moneda  ,default: '' ,limit: Domain::MONEDA    ,null: false
      t.string :email           ,default: '' ,limit: Domain::EMAIL
      t.string :telefono1       ,default: '' ,limit: Domain::TELEFONO  ,null: false
      t.string :telefono2       ,default: '' ,limit: Domain::TELEFONO  ,null: false

      t.timestamps
    end
  end
end

class CreateCuentasContable < ActiveRecord::Migration
  def change
    create_table :cuentas_contable do |t|
      t.string   :nombre    ,default: ''    ,limit: Domain::NOMBRE ,null: false
      t.string   :nivel     ,default: ''    ,limit: Domain::NIVEL ,null: false
      t.boolean  :asentable ,default: false ,limit: Domain::NUMERO_DOC_COM ,null: false
      t.string   :codigo    ,default: ''    ,limit: Domain::CODIGO ,null: false
      t.timestamps
    end
  end
end

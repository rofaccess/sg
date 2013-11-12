class CreateAsientosContable < ActiveRecord::Migration
  def change
    create_table :asientos_contable do |t|
      t.string    :numero      ,null: false ,default: '' ,limit: Domain::NUM_ASIENTO
      t.string    :concepto    ,null: false ,default: '' ,limit: Domain::DESCRIPCION
      t.datetime  :fecha       ,null: false
      t.decimal   :monto_total ,null: false ,default: 0
      t.string  :numero_doc_com     ,default: '' ,limit: Domain::NUMERO_DOC_COM

      t.timestamps
    end
  end
end

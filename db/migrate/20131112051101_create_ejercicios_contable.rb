class CreateEjerciciosContable < ActiveRecord::Migration
  def change
    create_table :ejercicios_contable do |t|
    	t.datetime  :fecha_inicio ,null: false
    	t.datetime  :fecha_fin
    	t.string	:year      ,null: false ,default: '' ,limit: Domain::YEAR
    	t.boolean	:abierto   ,null: false ,default: true

      t.timestamps
    end
  end
end

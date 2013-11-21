class CreateNotasCreditoCompraDetalle < ActiveRecord::Migration
  def change
    create_table :notas_credito_compra_detalle do |t|
      t.integer :nota_credito_compra_id ,null: false
      t.integer :componente_id     ,null: false
      t.integer :cantidad          ,null: false ,default: 0
      t.decimal :costo_unitario    ,null: false ,default: 0
      t.integer :factura_compra_detalle_id ,null:false

      t.timestamps
    end

    add_foreign_key(:notas_credito_compra_detalle, :notas_credito_compra, column: 'nota_credito_compra_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:notas_credito_compra_detalle, :mercaderias, column: 'componente_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:notas_credito_compra_detalle, :facturas_compra_detalle, column: 'factura_compra_detalle_id', options: 'ON DELETE RESTRICT')
  end
end

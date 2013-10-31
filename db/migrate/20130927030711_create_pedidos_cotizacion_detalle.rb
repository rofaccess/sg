class CreatePedidosCotizacionDetalle < ActiveRecord::Migration
  def change
    create_table :pedidos_cotizacion_detalle do |t|
      t.integer :pedido_cotizacion_id ,null: false
      t.integer :componente_id        ,null: false
      t.integer :cantidad_requerida   ,null: false, default: 0
      t.integer :cantidad_cotizada    ,default: 0
      t.decimal :costo_unitario       ,default: 0
      t.integer :pedido_compra_detalle_id ,null: false

      t.timestamps
    end

    add_foreign_key(:pedidos_cotizacion_detalle, :pedidos_cotizacion, column: 'pedido_cotizacion_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:pedidos_cotizacion_detalle, :mercaderias, column: 'componente_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:pedidos_cotizacion_detalle, :pedidos_compra_detalle, column: 'pedido_compra_detalle_id', options: 'ON DELETE RESTRICT')
  end
end

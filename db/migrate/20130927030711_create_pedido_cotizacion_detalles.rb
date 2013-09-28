class CreatePedidoCotizacionDetalles < ActiveRecord::Migration
  def change
    create_table :pedidos_cotizacion_detalle do |t|
      t.integer :pedido_cotizacion_id
      t.integer :componente_id
      t.integer :cantidad_requerida
      t.integer :cantidad_cotizada
      t.decimal :costo_unitario

      t.timestamps
    end

    add_foreign_key(:pedidos_cotizacion_detalle, :pedidos_cotizacion, column: 'pedido_cotizacion_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:pedidos_cotizacion_detalle, :componentes, column: 'componente_id', options: 'ON DELETE RESTRICT')
  end
end

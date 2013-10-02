json.array!(@ordenes_compras) do |orden_compra|
  json.extract! orden_compra, :numero, :fecha, :costo_total, :estado, :user_id, :proveedor_id, :pedido_cotizacion_id
  json.url orden_compra_url(orden_compra, format: :json)
end

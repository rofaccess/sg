# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
  inflect.irregular 'localidad', 'localidades'
  inflect.irregular 'pais', 'paises'
  inflect.irregular 'estado', 'estados'
  inflect.irregular 'ciudad', 'ciudades'
  inflect.irregular 'configuracion', 'configuraciones'
  inflect.irregular 'componente_categoria', 'componentes_categoria'
  inflect.irregular 'pedido_compra', 'pedidos_compra'
  inflect.irregular 'pedido_compra_detalle', 'pedidos_compra_detalle'
  inflect.irregular 'proveedor', 'proveedores'
  inflect.irregular 'condicion_pago', 'condiciones_pago'
  inflect.irregular 'plazo_pago', 'plazos_pago'
  inflect.irregular 'plazo_pago_detalle', 'plazos_pago_detalle'
  inflect.irregular 'factura_compra', 'facturas_compra'
  inflect.irregular 'factura_compra_detalle', 'facturas_compra_detalle'
  inflect.irregular 'pedido_cotizacion', 'pedidos_cotizacion'
  inflect.irregular 'pedido_cotizacion_detalle', 'pedidos_cotizacion_detalle'
  inflect.irregular 'orden_compra', 'ordenes_compra'
  inflect.irregular 'orden_compra_detalle', 'ordenes_compra_detalle'
  inflect.irregular 'componente_categoria_proveedor', 'componentes_categoria_proveedores'
  inflect.irregular 'mercaderia', 'mercaderias'
  inflect.irregular 'deposito_stock', 'depositos_stock'
  inflect.irregular 'deposito_materia_prima', 'depositos_materia_prima'
  inflect.irregular 'deposito_producto_terminado', 'depositos_producto_terminado'
  inflect.irregular 'orden_devolucion', 'ordenes_devolucion'
  inflect.irregular 'orden_devolucion_detalle', 'ordenes_devolucion_detalle'
  inflect.uncountable %w( fish sheep )
end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

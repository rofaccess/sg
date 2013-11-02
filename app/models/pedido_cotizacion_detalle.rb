class PedidoCotizacionDetalle < ActiveRecord::Base
  include Formatter

  belongs_to :pedido_cotizacion
  belongs_to :componente
  belongs_to :pedido_compra_detalle

  def proveedores
  	PedidoCotizacionDetalle.includes(:pedido_cotizacion).where('pedidos_cotizacion.estado = ?', 'Cotizado').where('costo_unitario <> ?', 0).where(pedido_compra_detalle: self.pedido_compra_detalle, componente_id: self.componente_id)
  end

  def costo_unitario_f
	Formatter.to_money(self.costo_unitario)
  end
end

class PedidoCompraDetalle < ActiveRecord::Base
  acts_as_paranoid

  belongs_to 	:pedido_compra
  belongs_to 	:componente
  has_many 	:pedido_cotizacion_detalles

  # Retorna los pedido_cotizacion_detalles de pedidos ya cotizados
  def cotizados
    cotizaciones = self.pedido_cotizacion_detalles
    cotizados = []
    cotizaciones.each do |c|
	  cotizados.push(c) if c.pedido_cotizacion.estado == PedidosEstados::COTIZADO && !c.costo_unitario.nil? && c.costo_unitario != 0
    end
    cotizados
  end
end

class PedidoCompraDetalle < ActiveRecord::Base
	belongs_to 	:pedido_compra
	belongs_to 	:componente
	has_many 	:pedido_cotizacion_detalles

	# Retorna los pedido_cotizacion_detalles de pedidos ya cotizados
	def cotizados
		cotizaciones = self.pedido_cotizacion_detalles
		cotizados = []
		cotizaciones.each do |c|
			cotizados.push(c) if c.pedido_cotizacion.estado == PedidosEstados::COTIZADO
		end
		cotizados
	end
end

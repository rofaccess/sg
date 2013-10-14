class OrdenCompra < ActiveRecord::Base
	belongs_to :user
	belongs_to :proveedor
	belongs_to :pedido_cotizacion
	belongs_to :orden_compra
	has_many   :orden_compra_detalles
	has_many   :factura_compras


	def self.procesados
    	OrdenCompra.where(estado: PedidosEstados::PROCESADO)
  	end
end

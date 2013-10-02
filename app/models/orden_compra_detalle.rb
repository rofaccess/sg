class OrdenCompraDetalle < ActiveRecord::Base
	belongs_to :orden_compra
	belongs_to :componente

	def self.procesados
    	OrdenCompra.where(estado: PedidosEstados::PROCESADO)
  	end
end

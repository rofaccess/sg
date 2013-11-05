class OrdenCompra < ActiveRecord::Base
	include Formatter

	protokoll :numero, pattern: '#####'
    paginates_per 15

	belongs_to :user
	belongs_to :proveedor
	belongs_to :pedido_cotizacion
	#belongs_to :orden_compra
	belongs_to :pedido_compra
	has_many   :orden_compra_detalles
	has_many   :factura_compras


	def self.procesados
    	OrdenCompra.where(estado: PedidosEstados::PROCESADO)
  	end

  	def total_requerido_f
  		Formatter.to_money(self.total_requerido)
	end
end

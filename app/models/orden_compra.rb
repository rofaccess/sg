class OrdenCompra < ActiveRecord::Base
	include Formatter

	protokoll :numero, pattern: '#####'
    paginates_per 15
    has_paper_trail
    acts_as_paranoid

	belongs_to :user, with_deleted: true
	belongs_to :proveedor, with_deleted: true
	belongs_to :pedido_cotizacion, with_deleted: true
	has_many   :orden_devolucions
	belongs_to :pedido_compra, with_deleted: true
	has_many   :orden_compra_detalles
	has_many   :factura_compras


	def self.procesados
    	OrdenCompra.where(estado: PedidosEstados::PROCESADO)
  	end

  	def total_requerido_f
  		Formatter.to_money(self.total_requerido)
	end
end

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

	def self.get_orden_pendiente_semifacturado_con_componente(componente_id)
	    ordenes_compra = OrdenCompra.where('estado = ? OR estado = ?', PedidosEstados::PENDIENTE,PedidosEstados::SEMIFACTURADO)
	    ordenes_compra.each do |orden|
	      orden_compra_detalle = OrdenCompraDetalle.where('orden_compra_id = ? AND componente_id = ?', orden.id, componente_id).first
	      if not orden_compra_detalle.blank?
	        if orden_compra_detalle.cantidad_requerida > orden_compra_detalle.cantidad_recibida
	        	return orden
	      	end
	      end
	    end
	    return nil
  	end
end

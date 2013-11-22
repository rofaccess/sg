class DepositoStock < ActiveRecord::Base
	belongs_to :deposito
	belongs_to :mercaderia

	# Suma al stock
  	def self.actualizar_deposito_stock(factura_compra, factura_compra_detalle, orden_compra_detalle)
	    deposito = DepositoStock.where("deposito_id = ? AND mercaderia_id = ?", factura_compra.deposito_id, factura_compra_detalle.componente_id).first
	    if deposito.blank?
	      # Carga el deposito_stock por primera vez
	      DepositoStock.create( deposito_id: factura_compra.deposito_id,
	                    mercaderia_id: factura_compra_detalle.componente_id,
	                    existencia: factura_compra_detalle.cantidad,
	                    existencia_min: 10,
	                    existencia_max: 20)
	    else
	      # Actualiza el deposito_stock
	      cant = deposito.existencia
	      cant_nueva = cant + factura_compra_detalle.cantidad
	      # Cuando el componente del detalle de la orden se recibio totalmente, el deposito_stock correspondiente
	      # al componente mencionado, se actualiza su pedido generado a no
	      if orden_compra_detalle.cantidad_recibida == orden_compra_detalle.cantidad_requerida
	        deposito.update(existencia: cant_nueva, pedido_generado: "No")
	      else
	        deposito.update(existencia: cant_nueva)
	      end

	      # Actualiza la existencia_total en componentes
		  componente = Componente.find(factura_compra_detalle.componente_id)
		  exist_comp = componente.existencia_total
		  componente.update(existencia_total: (exist_comp + factura_compra_detalle.cantidad))
	    end
  	end

  	# Resta del stock
  	def self.restar_deposito_stock(nota_credito, nota_credito_detalle)
		deposito = DepositoStock.where("deposito_id = ? AND mercaderia_id = ?", nota_credito.factura_compra.deposito_id, nota_credito_detalle.componente_id).first
		cant_dep = deposito.existencia
		deposito.update(existencia: (cant_dep - nota_credito_detalle.cantidad))

		# Actualiza la existencia_total en componentes
		componente = Componente.find(nota_credito_detalle.componente_id)
		exist_comp = componente.existencia_total
		componente.update(existencia_total: (exist_comp - nota_credito_detalle.cantidad))
  	end
end

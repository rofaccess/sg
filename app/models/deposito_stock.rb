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

	      componente = Componente.find(factura_compra_detalle.componente_id)
		  exist_total_actual = componente.existencia_total
		  exist_total_nueva = exist_total_actual + factura_compra_detalle.cantidad

		  costo_exist_total_actual = exist_total_actual * componente.costo
		  costo_exist_total_nueva = factura_compra_detalle.cantidad * factura_compra_detalle.costo_unitario
		  nuevo_costo = ((costo_exist_total_actual + costo_exist_total_nueva) / (exist_total_nueva + 0.0)).round

	      # Actualiza la existencia_total del componente y el costo por el metodo PPP
		  componente.update(existencia_total: exist_total_nueva, costo: nuevo_costo)
	    end
  	end

  	# Resta del stock
  	def self.restar_deposito_stock(nota_credito, nota_credito_detalle)
		deposito = DepositoStock.where("deposito_id = ? AND mercaderia_id = ?", nota_credito.factura_compra.deposito_id, nota_credito_detalle.componente_id).first
		cant_dep = deposito.existencia
		deposito.update(existencia: (cant_dep - nota_credito_detalle.cantidad))

		componente = Componente.find(nota_credito_detalle.componente_id)
		exist_total_actual = componente.existencia_total
		exist_total_nueva = exist_total_actual - nota_credito_detalle.cantidad

		costo_exist_total_actual = exist_total_actual * componente.costo
		costo_exist_total_nueva = nota_credito_detalle.cantidad * nota_credito_detalle.costo_unitario
		nuevo_costo = ((costo_exist_total_actual - costo_exist_total_nueva) / (exist_total_nueva + 0.0)).round

	    # Actualiza la existencia_total del componente y el costo por el metodo PPP
		componente.update(existencia_total: exist_total_nueva, costo: nuevo_costo)
  	end
end

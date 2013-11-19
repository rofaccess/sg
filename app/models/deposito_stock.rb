class DepositoStock < ActiveRecord::Base
	belongs_to :deposito
	belongs_to :mercaderia
	# def self.actualizar_deposito_stock(factura_compra)
	# 	factura_compra.factura_compra_detalles.each do |f|
	# 		deposito = DepositoStock.where("deposito_id = ? AND mercaderia_id = ?", factura_compra.deposito_id, f.componente_id).first
	# 		if deposito.blank?
	# 			DepositoStock.create( deposito_id: factura_compra.deposito_id,
	# 								  mercaderia_id: f.componente_id,
	# 								  existencia: f.cantidad)
	# 		else
	# 			cant = deposito.existencia
	# 			cant_nueva = cant + f.cantidad
	# 			# Cuando la existencia alcanza la existencia_max, se indica que ya no hay pedido generado
	# 			if cant_nueva == deposito.existencia_max
	# 			  deposito.update(existencia: cant_nueva, pedido_generado: "No")
	# 			else
	# 			  deposito.update(existencia: cant_nueva)
	# 			end
	# 		end
	# 	end
	# end
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
	    end
  	end
end

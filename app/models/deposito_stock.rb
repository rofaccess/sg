class DepositoStock < ActiveRecord::Base
	belongs_to :deposito
	belongs_to :mercaderia
	def self.actualizar_deposito_stock(factura_compra)
		factura_compra.factura_compra_detalles.each do |f|
			deposito = DepositoStock.where("deposito_id = ? AND mercaderia_id = ?", factura_compra.deposito_id, f.componente_id).first
			if deposito.blank?
				DepositoStock.create( deposito_id: factura_compra.deposito_id,
									  mercaderia_id: f.componente_id,
									  existencia: f.cantidad)
			else
				cant = deposito.existencia
				cant_nueva = cant + f.cantidad
				# Cuando la existencia alcanza la existencia_max, se indica que ya no hay pedido generado
				if cant_nueva == deposito.existencia_max
				  deposito.update(existencia: cant_nueva, pedido_generado: "No")
				else
				  deposito.update(existencia: cant_nueva)
				end
			end
		end
	end
end

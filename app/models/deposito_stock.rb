class DepositoStock < ActiveRecord::Base
	belongs_to :deposito
	belongs_to :mercaderia
	def self.actualizar_deposito_stock(deposito_id, factura_compra_id)
		facturaCompraDetalles = FacturaCompraDetalle.where(factura_compra_id: factura_compra_id)
		facturaCompraDetalles.each do |f|
			deposito = DepositoStock.where("deposito_id = ? AND mercaderia_id = ?", deposito_id, f.componente_id).first
			if deposito.blank?
				DepositoStock.create( deposito_id: deposito_id,
									  mercaderia_id: f.componente_id,
									  existencia: f.cantidad)
			else
				cantidad = deposito.existencia
				deposito.update(existencia: (cantidad + f.cantidad))
			end
		end
	end
end

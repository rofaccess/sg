class OrdenCompraDetalle < ActiveRecord::Base
	include Formatter

	belongs_to :orden_compra
	belongs_to :componente
	has_many   :factura_compra_detalles

	def costo_unitario_f
		Formatter.to_money(self.costo_unitario)
	end
end

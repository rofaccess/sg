class OrdenCompraDetalle < ActiveRecord::Base
	include Formatter
    acts_as_paranoid

	belongs_to :orden_compra, with_deleted: true
	belongs_to :componente, with_deleted: true
	has_many   :factura_compra_detalles


	def costo_unitario_f
		Formatter.to_money(self.costo_unitario)
	end
end

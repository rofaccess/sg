class FacturaCompra < ActiveRecord::Base
	has_many   :factura_compra_detalles
	belongs_to :orden_compra
	belongs_to :proveedor
	belongs_to :condicion_pago
	belongs_to :plazo_pago
	belongs_to :user

	accepts_nested_attributes_for :factura_compra_detalles
end

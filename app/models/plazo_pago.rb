class PlazoPago < ActiveRecord::Base
	has_many :factura_compras
	has_many :plazo_pago_detalles

	accepts_nested_attributes_for :plazo_pago_detalles, reject_if: :all_blank, allow_destroy: true
end

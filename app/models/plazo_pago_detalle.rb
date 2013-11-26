class PlazoPagoDetalle < ActiveRecord::Base
	belongs_to :plazo_pago, with_deleted: true
end

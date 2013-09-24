class PlazoPagoDetalle < ActiveRecord::Base
	has_many :facturas_compra
end

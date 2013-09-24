class PlazoPago < ActiveRecord::Base
	has_many :facturas_compra
end

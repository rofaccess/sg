class CondicionPago < ActiveRecord::Base
	has_many :facturas_compra
end

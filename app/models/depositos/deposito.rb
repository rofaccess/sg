class Deposito < ActiveRecord::Base
	paginates_per 15
	has_many :deposito_stocks
	has_many :facturas_compra
	has_many :pedidos_compra
end

class FacturaCompraDetalle < ActiveRecord::Base
	belongs_to :factura_compra
	belongs_to :componente
end

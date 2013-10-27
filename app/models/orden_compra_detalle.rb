class OrdenCompraDetalle < ActiveRecord::Base
	belongs_to :orden_compra
	belongs_to :componente
	has_many   :factura_compra_detalles
end

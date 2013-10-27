class FacturaCompraDetalle < ActiveRecord::Base
	belongs_to :factura_compra
	belongs_to :componente
	belongs_to :orden_compra_detalle
end

class FacturaCompraDetalle < ActiveRecord::Base
	belongs_to :orden_compra
	belongs_to :componente
end

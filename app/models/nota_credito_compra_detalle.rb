class NotaCreditoCompraDetalle < ActiveRecord::Base
	belongs_to :componente
	belongs_to :nota_credito_compra
	belongs_to :factura_compra_detalle

end

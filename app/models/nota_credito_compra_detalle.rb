class NotaCreditoCompraDetalle < ActiveRecord::Base

	acts_as_paranoid

	belongs_to :componente
	belongs_to :nota_credito_compra
	belongs_to :factura_compra_detalle

end

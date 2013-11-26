class NotaCreditoCompraDetalle < ActiveRecord::Base

	acts_as_paranoid

	belongs_to :componente, with_deleted: true
	belongs_to :nota_credito_compra, with_deleted: true
	belongs_to :factura_compra_detalle, with_deleted: true

end

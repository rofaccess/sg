class NotaCreditoCompra < ActiveRecord::Base
	has_paper_trail
	acts_as_paranoid

	belongs_to :user
	belongs_to :proveedor
	belongs_to :factura_compra

	has_many :nota_credito_compra_detalles
end

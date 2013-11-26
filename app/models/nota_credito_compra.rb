class NotaCreditoCompra < ActiveRecord::Base
	has_paper_trail
	acts_as_paranoid

	belongs_to :user, with_deleted: true
	belongs_to :proveedor, with_deleted: true
	belongs_to :factura_compra, with_deleted: true

	has_many :nota_credito_compra_detalles
	accepts_nested_attributes_for :nota_credito_compra_detalles
end

class NotaCreditoCompra < ActiveRecord::Base
	belongs_to :user
	belongs_to :proveedor
	belongs_to :factura_compra

	has_many :nota_credito_compra_detalles
	accepts_nested_attributes_for :nota_credito_compra_detalles
end

class OrdenCompra < ActiveRecord::Base
	belongs_to :user
	belongs_to :proveedor
	belongs_to :pedido_cotizacion
	has_many :ordenes_compra_detalle
end
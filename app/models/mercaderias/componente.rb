class Componente < Mercaderia
	paginates_per 15
	belongs_to :marca, with_deleted: true
	belongs_to :componente_categoria, with_deleted: true
	has_many :pedidos_compra_detalle
	has_many :factura_compra_detalles
	has_many :pedidos_cotizacion_detalles
	has_many :orden_compra_detalles
	has_many :nota_credito_compra_detalles
end

class Componente < ActiveRecord::Base
	belongs_to :marca
	belongs_to :componente_categoria
	belongs_to :iva
	has_many :pedidos_compra_detalle
	has_many :factura_compra_detalles
	has_many :pedidos_cotizacion_detalles
	has_many :orden_compra_detalles
end

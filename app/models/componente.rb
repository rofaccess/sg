class Componente < ActiveRecord::Base
	belongs_to :marca
	belongs_to :componente_categoria
	has_many :pedidos_compra_detalle
	has_many :facturas_compra_detalle
	has_many :pedidos_cotizacion_detalles
	has_many :ordenes_compra_detalle
end

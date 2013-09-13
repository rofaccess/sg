class Componente < ActiveRecord::Base
	belongs_to :marca
	belongs_to :componente_categoria
	has_many :pedidos_compra_detalle
end

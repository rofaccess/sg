class Componente < ActiveRecord::Base
	belongs_to :marca
	belongs_to :componente_categoria
	validates :nombre, :numero_serie, :costo, presence: true
end

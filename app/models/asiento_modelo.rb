class AsientoModelo < ActiveRecord::Base
	has_many :asiento_modelo_detalles

	accepts_nested_attributes_for :asiento_modelo_detalles
end

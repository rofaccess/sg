class Persona < ActiveRecord::Base
	has_one :proveedor
	belongs_to :ciudad
end

class Persona < ActiveRecord::Base
	belongs_to :ciudad

	# validates :nombre, :ruc, :direccion, :email, :ciudad_id, presence: true
end

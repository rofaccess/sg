class Persona < ActiveRecord::Base
	belongs_to :ciudad
	has_many   :telefonos

	accepts_nested_attributes_for :telefonos

	# validates :nombre, :ruc, :direccion, :email, :ciudad_id, presence: true
end

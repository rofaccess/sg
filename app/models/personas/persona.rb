class Persona < ActiveRecord::Base
	belongs_to :ciudad
	has_many   :telefonos

	accepts_nested_attributes_for :telefonos, :reject_if => :all_blank, :allow_destroy => true
	# validates :nombre, :ruc, :direccion, :email, :ciudad_id, presence: true
end

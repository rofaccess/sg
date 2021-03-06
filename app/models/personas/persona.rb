class Persona < ActiveRecord::Base
	belongs_to :ciudad, with_deleted: true
	has_many   :telefonos
	acts_as_paranoid

	accepts_nested_attributes_for :telefonos, :reject_if => :all_blank, :allow_destroy => true
	# validates :nombre, :ruc, :direccion, :email, :ciudad_id, presence: true
end

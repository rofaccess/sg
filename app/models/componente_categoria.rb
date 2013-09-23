class ComponenteCategoria < ActiveRecord::Base
	has_many :componentes
	has_and_belongs_to_many :providers
	has_and_belongs_to_many :proveedores

	validates :nombre, presence: true
end

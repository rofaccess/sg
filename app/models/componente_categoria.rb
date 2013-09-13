class ComponenteCategoria < ActiveRecord::Base
	has_many :componentes
	validates :nombre, presence: true
end

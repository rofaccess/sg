class ComponenteCategoria < ActiveRecord::Base
	has_many :componentes
	has_and_belongs_to_many :proveedores, join_table: 'componentes_categorias_proveedores'

	validates :nombre, presence: true
end

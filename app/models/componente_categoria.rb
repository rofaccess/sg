class ComponenteCategoria < ActiveRecord::Base
	has_many :componentes
	has_and_belongs_to_many :proveedores, join_table: 'componentes_categorias_proveedores'

	validates :nombre, presence: true

	#Retornar los proveedores que pertenezcan a categoris dadas
	def self.get_proveedores(categorias)
		proveedores = []
		categorias.each do |c|
			categoria = ComponenteCategoria.find(c)
			proveedores = proveedores | categoria.proveedor_ids
		end

		proveedores
	end
end

class ComponenteCategoria < ActiveRecord::Base
	paginates_per 15
	has_many :componentes
	has_and_belongs_to_many :proveedores, join_table: 'componentes_categoria_proveedores'

	validates :nombre, presence: true
	acts_as_paranoid
	has_paper_trail

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

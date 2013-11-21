class Proveedor < Persona
	paginates_per 15
	has_paper_trail meta: {type_subclase: 'Proveedor'}
	acts_as_paranoid

	has_and_belongs_to_many :componente_categorias, join_table: 'componentes_categoria_proveedores'
	has_many :facturas_compra
	has_many :ordenes_compras
	has_many :orden_devolucions
	has_many :nota_debito_compras
	has_many :nota_credito_compras
end

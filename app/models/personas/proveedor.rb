class Proveedor < Persona
	paginates_per 15
	has_and_belongs_to_many :componente_categorias, join_table: 'componentes_categoria_proveedores'
	has_many :facturas_compra
	has_many :ordenes_compras
	has_many :orden_devolucions
end

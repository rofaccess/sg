class Proveedor < Persona
	has_and_belongs_to_many :componente_categorias, join_table: 'componentes_categorias_proveedores'
	has_many :facturas_compra
end
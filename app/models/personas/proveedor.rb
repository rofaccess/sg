class Proveedor < Persona
	has_and_belongs_to_many :componente_categorias, join_table: 'componentes_categoria_proveedores'
	has_many :facturas_compra
	has_many :ordenes_compras
end

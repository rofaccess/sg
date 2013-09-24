class Proveedor < Persona
	has_and_belongs_to_many :componente_categorias
	has_many :facturas_compra
end

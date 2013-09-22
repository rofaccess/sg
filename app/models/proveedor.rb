class Proveedor < ActiveRecord::Base
	#has_and_belongs_to_many :componente_categorias
	belongs_to :persona
	#accepts_nested_attributes_for :persona
end

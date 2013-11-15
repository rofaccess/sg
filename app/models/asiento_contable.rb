class AsientoContable < ActiveRecord::Base

	protokoll :numero, pattern: '#####'
	has_many :asiento_contable_detalles
	belongs_to :ejercicios_contable

	def self.asentar_carga_factura_credito(factura_compra, asiento_modelo)
		
	end
end

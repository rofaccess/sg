class AsientoModelo < ActiveRecord::Base
	has_many :asiento_modelo_detalles

	accepts_nested_attributes_for :asiento_modelo_detalles

	#has_paper_trail

	# Obiene cada valor que podria intervenir en el modelo factura
	def self.filtrar_valores_carga_factura_credito
		valores = ["Monto sin Iva"]
		Iva.all.each do |iva|
			valores.push("Iva #{iva.valor}%")
		end
		valores.push("Monto Total")
	end
end

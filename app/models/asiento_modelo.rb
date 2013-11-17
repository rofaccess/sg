class AsientoModelo < ActiveRecord::Base
	has_many :asiento_modelo_detalles

	accepts_nested_attributes_for :asiento_modelo_detalles

	# Obiene cada valor que podria intervenir en el modelo factura
	def self.filtrar_valores_carga_factura_credito
		valores = ["Monto sin Iva","Monto Total"]
		Iva.all.each do |iva|
			valores.push("Iva #{iva.valor}%")
		end
		valores
	end
end

class AsientoContable < ActiveRecord::Base

	protokoll :numero, pattern: '#####'
	has_many :asiento_contable_detalles
	belongs_to :ejercicio_contable

	# Se usa este metodo cuando la factura que se carga tiene condicion credito
	def self.asentar_carga_factura_credito(factura_compra)
	  asiento_modelo = AsientoModelo.find_by(origen: 'Carga de Factura Compra, Condicion Credito')
	  valores = FacturaCompra.filtrar_valores_carga_factura_credito(factura_compra)
	  ejercicio_contable = EjercicioContable.where("year = ? AND abierto = ?", DateTime.now.year, true).first

	  asiento_contable = AsientoContable.new( ejercicio_contable_id: ejercicio_contable.id,
	  										  concepto: asiento_modelo.concepto,
	  										  fecha: DateTime.now,
	  										  numero_doc_com: factura_compra.numero)
	  total_debe = 0
	  total_haber = 0
	  asiento_modelo.asiento_modelo_detalles.each do |a_m_d|
	  	if (valores.key?(a_m_d.valor))
	  		asiento_contable.asiento_contable_detalles.build( cuenta_contable_id: a_m_d.cuenta_contable_id,
	  													      tipo_partida_doble: a_m_d.tipo_partida_doble,
	  													      monto: valores[a_m_d.valor])
	  		if a_m_d.tipo_partida_doble == "Debe"
	  			total_debe += valores[a_m_d.valor]
	  		else
	  			total_haber += valores[a_m_d.valor]
	  		end
	  	end
	  end
	  if total_debe == total_haber
	  	asiento_contable.monto_total = total_debe
	  end
	  asiento_contable.save
	end
end
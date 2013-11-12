class AsientosContable < ActiveRecord::Base

	protokoll :numero, pattern: '#####'
	has_many :asiento_contable_detalles

	# def self.asiento_automatico_credito(asiento_modelo_id, factura_id)
	# 	factura = FacturaCompra.find(factura_id)
	# 	asiento_modelo = AsientoModelo.find(asiento_modelo_id)
	# 	asiento_contable = AsientoContable.create( concepto: asiento_modelo.concepto,
	# 											   monto_total: factura.total_factura,
	# 											   fecha: factura.fecha,
	# 											   numero_doc_com: factura.numero)
	# 	asiento_modelo.asiento_modelo_detalles.each do |a|
	# 		AsientoContableDetalle.create(asiento_contable_id: asiento_contable_id,
	# 									  cuenta_contable_id: a.cuenta_contable_id,
	# 									  tipo_partida_doble: a.tipo_partida_doble,
	# 									  monto: '?')
	# 	end
	# end
end

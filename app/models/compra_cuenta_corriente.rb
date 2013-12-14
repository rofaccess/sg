class CompraCuentaCorriente < ActiveRecord::Base
	belongs_to :proveedor, with_deleted: true
	has_many   :compra_cuenta_corriente_facturas

	def self.actualizar_cuenta_corriente(factura)
		cta_cte = CompraCuentaCorriente.find_by(proveedor_id: factura.proveedor_id)
		if cta_cte.blank?
			# Si el proveedor de la factura no tiene cta cte, se crea la cta
			cta_cte = CompraCuentaCorriente.new(proveedor_id: factura.proveedor_id,
												fecha_creacion: DateTime.now,
												saldo: factura.total_factura)
			cta_cte_factura = cta_cte.compra_cuenta_corriente_facturas.new(factura_compra_id: factura.id,
														                   saldo_factura: factura.total_factura,
														                   cuotas: factura.plazo_pago.cuotas)
			cuota_numero = 0
			# Se puede mejorar el importe
			importe_cuota = ((factura.total_factura + 0.0)/(factura.plazo_pago.cuotas.to_i)).round
			factura.plazo_pago.plazo_pago_detalles.each do |plazo_detalle|
				cuota_numero += 1
				cta_cte_factura.compra_cuenta_corriente_cuotas.new(cuota_numero: cuota_numero,
											                       fecha_vencimiento: (factura.fecha.to_datetime + (plazo_detalle.cant_dias.to_i)),
											                       importe_cuota: importe_cuota)
			end
			cta_cte.save
		else
			# Si ya existe la cta, se crean nuevos detalles
			cta_cte_factura = CompraCuentaCorrienteFactura.new(compra_cuenta_corriente_id: cta_cte.id,
															   factura_compra_id: factura.id,
														       saldo_factura: factura.total_factura,
														       cuotas: factura.plazo_pago.cuotas)
			cuota_numero = 0
			# Se puede mejorar el importe
			importe_cuota = ((factura.total_factura + 0.0)/(factura.plazo_pago.cuotas.to_i)).round
			factura.plazo_pago.plazo_pago_detalles.each do |plazo_detalle|
				cuota_numero += 1
				cta_cte_factura.compra_cuenta_corriente_cuotas.new(cuota_numero: cuota_numero,
											                       fecha_vencimiento: (factura.fecha.to_datetime + (plazo_detalle.cant_dias.to_i)),
											                       importe_cuota: importe_cuota)
			end
			cta_cte_factura.save
			# Se actualiza la cuenta
			saldo_anterior = cta_cte.saldo
			cta_cte.update(saldo: (saldo_anterior + factura.total_factura))
		end
	end

	def self.actualizar_monto_credito(proveedor_id, monto)
		cta_cte = CompraCuentaCorriente.find_by(proveedor_id: proveedor_id)
		if cta_cte.blank?
			CompraCuentaCorriente.create(proveedor_id: proveedor_id,
										 fecha_creacion: DateTime.now,
										 monto_credito: monto)
		else
			monto_credito = cta_cte.monto_credito
			cta_cte.update(monto_credito: (monto + monto_credito))
		end
	end

	def self.actualizar_monto_debito(proveedor_id, monto)
		cta_cte = CompraCuentaCorriente.find_by(proveedor_id: proveedor_id)
		if cta_cte.blank?
			CompraCuentaCorriente.create(proveedor_id: proveedor_id,
									     fecha_creacion: DateTime.now,
										 monto_debito: monto)
		else
			monto_debito = cta_cte.monto_debito
			cta_cte.update(monto_debito: (monto + monto_debito))
		end
	end
end

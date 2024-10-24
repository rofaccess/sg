class FacturaCompra < ActiveRecord::Base
	self.skip_time_zone_conversion_for_attributes = [:fecha]
	paginates_per 15
	has_paper_trail
	acts_as_paranoid

	has_many   :factura_compra_detalles
	has_many   :nota_credito_compra_detalles
	has_many   :compra_cuenta_corriente_facturas
	belongs_to :orden_compra, with_deleted: true
	belongs_to :proveedor, with_deleted: true
	belongs_to :condicion_pago
	belongs_to :plazo_pago, with_deleted: true
	belongs_to :user, with_deleted: true
	belongs_to :deposito

	accepts_nested_attributes_for :factura_compra_detalles

	def self.filtrar(orden_compra_id = nil)
      orden_compra_id.nil? ? FacturaCompra.all : FacturaCompra.where(orden_compra_id: orden_compra_id)
	end

  	# Obtiene cada valor monetario que interviene en una factura que se va a cargar
	def self.filtrar_valores_carga_factura_credito(factura_compra)
		monto_total = factura_compra.total_factura
		monto_sin_iva = monto_total - factura_compra.total_iva
		valores = {"Monto sin Iva" => monto_sin_iva, "Monto Total" => monto_total}
		 factura_compra.factura_compra_detalles.each do |det|
		 	costo = det.costo_unitario * det.cantidad
		 	iva_porcentaje = ((det.iva_valor).to_i) / 100.0
		 	iva = (costo / (iva_porcentaje + 1) * iva_porcentaje).round
		 	iva_nuevo = valores["Iva #{det.iva_valor}%"].to_i + iva
		 	valores["Iva #{det.iva_valor}%"] = iva_nuevo
		 end
		valores
	end
end

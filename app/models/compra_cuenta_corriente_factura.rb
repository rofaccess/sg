class CompraCuentaCorrienteFactura < ActiveRecord::Base
	belongs_to :compra_cuenta_corriente
	belongs_to :factura_compra, with_deleted: true
	has_many   :compra_cuenta_corriente_cuotas
end

class CuentaContable < ActiveRecord::Base
	has_many :asiento_contable_detalles
	has_many :asiento_modelo_detalles
end

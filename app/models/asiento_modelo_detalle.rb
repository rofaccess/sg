class AsientoModeloDetalle < ActiveRecord::Base
	belongs_to :asiento_modelo
	belongs_to :cuenta_contable
end

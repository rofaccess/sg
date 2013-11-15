class AsientoContableDetalle < ActiveRecord::Base
	belongs_to :asiento_contable
	belongs_to :cuenta_contable
end

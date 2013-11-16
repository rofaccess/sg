class OrdenDevolucion < ActiveRecord::Base

	include Formatter

	protokoll :numero, pattern: '#####'
    paginates_per 15
    has_paper_trail
    acts_as_paranoid

    belongs_to :user
	belongs_to :proveedor
	belongs_to :orden_compra
	has_many   :orden_devolucion_detalles


end

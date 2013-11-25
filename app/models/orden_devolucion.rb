class OrdenDevolucion < ActiveRecord::Base

	include Formatter

	protokoll :numero, pattern: '#####'
    paginates_per 15
    has_paper_trail
    acts_as_paranoid

    belongs_to :user, with_deleted: true
	belongs_to :proveedor, with_deleted: true
	belongs_to :orden_compra
	has_many   :orden_devolucion_detalles

	accepts_nested_attributes_for :orden_devolucion_detalles


end

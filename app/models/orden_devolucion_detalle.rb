class OrdenDevolucionDetalle < ActiveRecord::Base

	include Formatter

	belongs_to :orden_devolucion
	belongs_to :componente

end

class OrdenDevolucionDetalle < ActiveRecord::Base

  include Formatter

  acts_as_paranoid

  belongs_to :orden_devolucion
  belongs_to :componente

end

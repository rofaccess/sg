class OrdenDevolucionDetalle < ActiveRecord::Base

  include Formatter

  acts_as_paranoid

  belongs_to :orden_devolucion, with_deleted: true
  belongs_to :componente, with_deleted: true

end

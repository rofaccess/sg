class FacturaCompraDetalle < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :factura_compra
  belongs_to :componente
  belongs_to :orden_compra_detalle
end

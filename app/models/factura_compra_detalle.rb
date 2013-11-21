class FacturaCompraDetalle < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :factura_compra
  belongs_to :componente
  belongs_to :orden_compra_detalle

  has_many :nota_credito_compra_detalles
end

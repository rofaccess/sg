class PedidoCotizacion < ActiveRecord::Base

  protokoll :numero, pattern: '#####'
  paginates_per 20

  has_many :pedido_cotizacion_detalles
  belongs_to :pedido_compra
  belongs_to :proveedor
  has_one :orden_compra

  accepts_nested_attributes_for :pedido_cotizacion_detalles

end

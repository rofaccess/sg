class PedidoCotizacion < ActiveRecord::Base

  protokoll :numero, pattern: '#####'
  paginates_per 20

  has_many :pedido_cotizacion_detalles
  belongs_to :pedido_compra
  belongs_to :proveedor
  has_many :orden_compras
  belongs_to :user

  accepts_nested_attributes_for :pedido_cotizacion_detalles

  def self.filtrar(pedido_compra_id = nil)
  	pedido_compra_id.nil? ? PedidoCotizacion.all : PedidoCotizacion.where(pedido_compra_id: pedido_compra_id)
  end

end

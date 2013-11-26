class PedidoCotizacion < ActiveRecord::Base
  protokoll :numero, pattern: '#####'
  paginates_per 15
  has_paper_trail
  acts_as_paranoid

  has_many :pedido_cotizacion_detalles, dependent: :destroy
  belongs_to :pedido_compra, with_deleted: true
  belongs_to :proveedor, with_deleted: true
  has_many :orden_compras
  belongs_to :user, with_deleted: true

  accepts_nested_attributes_for :pedido_cotizacion_detalles

  def self.filtrar(pedido_compra_id = nil)
  	pedido_compra_id.nil? ? PedidoCotizacion.all : PedidoCotizacion.where(pedido_compra_id: pedido_compra_id)
  end

end
